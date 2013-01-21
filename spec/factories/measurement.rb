FactoryGirl.define do

  factory :measurement do
    dataset
    measured_on {Date.today}
    value 100
  end
  
end