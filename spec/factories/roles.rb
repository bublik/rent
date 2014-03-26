# == Schema Information
#
# Table name: roles
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  resource_id   :integer
#  resource_type :string(255)
#  created_at    :datetime
#  updated_at    :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :admin do
    name: 'admin'
  end

  factory :manager do
    name: 'manager'
  end

  factory :vip_realtor do
    name: 'vip_realtor'
  end

  factory :realtor do
    name: 'realtor'
  end

end
