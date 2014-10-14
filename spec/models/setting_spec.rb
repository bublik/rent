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

require 'spec_helper'

describe Setting do
  pending "add some examples to (or delete) #{__FILE__}"
end
