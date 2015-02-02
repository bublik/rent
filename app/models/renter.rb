# == Schema Information
#
# Table name: renters
#
#  id             :integer          not null, primary key
#  phone          :string(255)
#  email          :string(255)
#  guard_time     :datetime
#  town           :string(255)
#  rooms          :string(255)
#  amount_from    :integer
#  check_in       :datetime
#  description    :text
#  created_at     :datetime
#  updated_at     :datetime
#  user_id        :integer          default(1), not null
#  orders_count   :integer          default(0), not null
#  check_out      :datetime
#  amount_to      :integer
#  state          :string(255)
#  published_at   :datetime
#  people         :integer
#  has_emailed    :boolean          default(FALSE), not null
#  phone_format   :string(255)      default("timer")
#  town_id        :integer
#  max_sales      :integer
#  agent          :boolean          default(FALSE)
#  town_area      :string(255)
#  show_check_in  :boolean          default(TRUE), not null
#  show_check_out :boolean          default(TRUE), not null
#

class Renter < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :town

  has_many :orders
  has_many :accesses
  has_many :users, through: :accsesses

  FORMATS = %w(timer last_digits everytime sold)
  validates :phone, :rooms, presence: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, allow_blank: true
  validates :amount_from, numericality: true, allow_nil: true
  validates :amount_to, numericality: true, allow_nil: true
  #validates :rooms, numericality: true
  validates :phone_format, inclusion: {in: FORMATS}
  attr_accessor :town_name, :flat_type

  scope :newest, -> { order('updated_at DESC') }
  scope :hide_inactive, -> { where('check_in >= ?', Time.now) }
  scope :by_state, ->(state) { where('state = ?', state) }
  scope :check_in_from, -> (date) { where('check_in >= ?', date) }
  scope :last24h, -> { where('created_at >= ?', Time.now - 24.hour) }
  scope :with_order, -> (user) { joins(:orders).where('orders.user_id =? ', user.id) }
  scope :published, -> { where('state IN (?) AND  published_at < ?', ['published','sold'],  Time.now) }
  scope :not_emailed, -> { where('has_emailed = ?', false) }

  after_initialize :preset
  after_create :new_message_notification
  after_create :check_autoconfirmation

  def preset
    self.guard_time ||= Time.now + 4.hours
    self.check_in ||= Time.now.change(hour: 13, min: 0, sec: 0)
    self.check_out ||= Time.now.change(hour: 12, min: 0, sec: 0)
  end

  state_machine initial: :new do
    event :publish do
      transition :new => :published
    end
    event :sale do
      transition :published => :sold
    end
  end

  def create_order(user)
    check_max_sales if Order.find_or_create_by(user_id: user.id, renter_id: self.id) && !user.is_admin?
  end

  def check_max_sales
    if (self.max_sales.to_i > 0) && (self.orders_count >= self.max_sales)
      self.sale
    end
  end

  def expired?
    (self.guard_time < Time.now)  #(self.check_in < Time.now)
  end

  # находим все сообщения которые в статусе published и больше чем published_at
  # разсылаем письма и блокируем для повторной отсылки
  def self.inform_new_paid_renters

    published.not_emailed.each do |renter|
      renter.update_column(:has_emailed, true)

      # Найдем всех рэлторов которые должны получить письма о новом платном объявлении
      order_user_ids = renter.orders.pluck(:user_id)
      User.where('users.id NOT IN (?)', order_user_ids).with_any_role(:realtor, :vip_realtor).each do |user|
        begin
          Notifications.new_public_renter(user, renter).deliver
        rescue => e
          Rails.logger.error(e.message)
        end
      end
      #пометим как уже отработанное
    end

  end

  def check_autoconfirmation
    if (setting = Setting.first) && setting.autoopen
      self.update_column(:published_at, Time.now + setting.autoopen_interval.to_i.minutes)
      self.update_column(:guard_time, Time.now + setting.guard_time.to_i.minutes)
      self.publish

      setting.users.each do |user_id|
        if order = Order.create!(user_id: user_id, renter_id: self.id, skip_payment: true)
          Notifications.access_to_renter(order.user, order.renter).deliver
        end
      end
    end
  end

  def new_message_notification
    User.with_role(:admin).subscribers.each do |user|
      Notifications.new_renter(user, self).deliver
    end
  end

end
