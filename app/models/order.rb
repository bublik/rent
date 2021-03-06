# == Schema Information
#
# Table name: orders
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  renter_id    :integer
#  created_at   :datetime
#  updated_at   :datetime
#  skip_payment :boolean          default(FALSE), not null
#

class Order < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :renter, counter_cache: true

  validate :user_id, :renter_id, presence: true
  validates_uniqueness_of :renter_id, scope: :user_id

  validate :check_user_balance, unless: :skip_payment
  after_create :decrement_user_balance, unless: :skip_payment

  def check_user_balance
    errors.add(:base, 'Пополните баланс!') if user.free_orders <= 0
  end

  def decrement_user_balance
    user.decrement!(:free_orders)
  end

end
