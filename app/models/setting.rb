class Setting < ActiveRecord::Base
  validates_numericality_of :autoopen_interval, greater_than_or_equal_to: 1

end
