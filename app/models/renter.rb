# == Schema Information
#
# Table name: renters
#
#  id           :integer          not null, primary key
#  phone        :string(255)
#  email        :string(255)
#  guard_time   :datetime
#  town         :string(255)
#  rooms        :integer
#  amount       :integer
#  сheck_in     :datetime
#  description  :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  user_id      :integer          default(1), not null
#  orders_count :integer          default(0), not null
#

class Renter < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  has_many :orders
  has_many :accesses
  has_many :users, through: :accsesses

  validates :user_id, :phone, :rooms, presence: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i}, allow_blank: true
  validates :amount, numericality: true, allow_nil: true
  validates :amount_grn, numericality: true, allow_nil: true
  validates :rooms, numericality: true

  scope :newest, -> { order('updated_at DESC') }
  scope :hide_inactive, -> { where('check_in >= ?', Time.now) }
  scope :by_state, ->(state) { where('state = ?', state) }
  scope :check_in_from, -> (date) { where('check_in >= ?', date) }
  scope :last24h, -> { where('created_at >= ?', Time.now - 24.hour) }
  scope :with_order, -> (user) { joins(:orders).where('orders.user_id =? ', user.id) }
  scope :published, -> { where('state = ? AND  published_at < ?', 'published', Time.now) }
  scope :not_emailed, -> { where('has_emailed = ?', false) }

  after_initialize :preset
  after_create :new_message_notification
  after_create :check_autoconfirmation

  def preset
    self.guard_time ||= Time.now + 4.hours
  end

  state_machine initial: :new do
    event :publish do
      transition :new => :published
    end
  end

  def create_order(user)
    Order.find_or_create_by(user_id: user.id, renter_id: self.id)
  end

  # находим все сообщения которые в статусе published и больше чем published_at
  # разсылаем письма и блокируем для повторной отсылки
  def self.inform_new_paid_renters

    published.not_emailed.each do |renter|
      renter.update_column(:has_emailed, true)

      # Найдем всех рэлторов которые должны получить письма о новом платном объявлении
      order_user_ids = renter.orders.pluck(:user_id)
      User.where('users.id NOT IN (?)', order_user_ids).with_any_role(:realtor, :vip_realtor).each do |user|
        Notifications.new_public_renter(user, renter).deliver
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
