# == Schema Information
#
# Table name: renters
#
#  id          :integer          not null, primary key
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

require 'spec_helper'

describe Renter do
  pending "add some examples to (or delete) #{__FILE__}"
end
