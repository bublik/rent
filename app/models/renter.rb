# == Schema Information
#
# Table name: renters
#
#  id          :integer          not null, primary key
#  user_id     :integer         not null, 1
#  phone       :string(255)
#  email       :string(255)
#  guard_time  :datetime
#  town        :string(255)
#  rooms       :integer
#  amount      :integer
#  сheck_in    :time
#  description :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Renter < ActiveRecord::Base
  belongs_to :user

  validate :user_id, :phone, :email, :town, :rooms, :amount, presence: true
  validates :email, format: {with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create}
  validates :amount, numericality: true
  validates :rooms, numericality: true
  scope :actual, -> { where('guard_time >= ?', Time.now) }

end
