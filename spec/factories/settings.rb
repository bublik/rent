# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :setting do
    autoopen false
    autoopen_interval "MyString"
  end
end
