# == Schema Information
#
# Table name: accesses
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  renter_id  :integer
#  counter    :integer
#  created_at :datetime
#  updated_at :datetime
#

class Access < ActiveRecord::Base
  belongs_to :user
  belongs_to :renter
  validates_uniqueness_of :renter_id, scope: :user_id

end
