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
  attr_accessor :public_access

  validate :user_id, :phone, :email, :town, :rooms, :amount, presence: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}
  validates :amount, numericality: true
  validates :rooms, numericality: true

  scope :actual, -> { where('guard_time >= ?', Time.now) }
  scope :with_order, -> (user) { joins(:orders).where('orders.user_id =? ', user.id) }

  def create_order(user)
    order = Order.find_or_create_by(user_id: user.id, renter_id: self.id)
    @public_access = order.new_record? ? false : true
  end

end
