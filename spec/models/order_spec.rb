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

require 'spec_helper'

describe Order do
  pending "add some examples to (or delete) #{__FILE__}"
end
