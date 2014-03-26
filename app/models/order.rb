class Order < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  belongs_to :renter, counter_cache: true

  validate :user_id, :renter_id, presence: true

end
