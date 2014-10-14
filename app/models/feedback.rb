# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  message    :text
#  created_at :datetime
#  updated_at :datetime
#

class Feedback < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :message

end
