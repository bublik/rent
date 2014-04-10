# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :access do
    user nil
    renter nil
    counter 1
  end
end
