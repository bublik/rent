# == Schema Information
#
# Table name: settings
#
#  id                :integer          not null, primary key
#  autoopen          :boolean
#  autoopen_interval :string(255)
#  created_at        :datetime
#  updated_at        :datetime
#  users             :string(255)      default("--- []\n")
#  guard_time        :integer          default(120)
#

class Setting < ActiveRecord::Base
  validates_numericality_of :autoopen_interval, greater_than_or_equal_to: 1
  validates_numericality_of :guard_time, greater_than_or_equal_to: 1

  serialize :users, Array

end
