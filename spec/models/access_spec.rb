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

require 'spec_helper'

describe Access do
  pending "add some examples to (or delete) #{__FILE__}"
end
