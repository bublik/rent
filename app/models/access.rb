class Access < ActiveRecord::Base
  belongs_to :user
  belongs_to :renter
  validates_uniqueness_of :renter_id, scope: :user_id

end
