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

  validates :user_id, :phone, :email, :town, :rooms, presence: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}
  validates :amount, numericality: true, allow_nil: true
  validates :amount_grn, numericality: true, allow_nil: true
  validates :rooms, numericality: true

  scope :newest, -> { order('updated_at DESC') }
  scope :hide_inactive, -> { where('check_in >= ?', Time.now) }
  scope :last24h, -> { where('created_at >= ?', Time.now - 24.hour) }
  scope :with_order, -> (user) { joins(:orders).where('orders.user_id =? ', user.id) }

  after_initialize :preset
  after_create :send_notification

  def preset
    self.guard_time ||= Time.now + 4.hours
  end

  def create_order(user)
    Order.find_or_create_by(user_id: user.id, renter_id: self.id)
  end

  def send_notification
    User.with_role(:admin).subscribers.each do |user|
      Notifications.new_renter(user, self).deliver
    end
  end

end
