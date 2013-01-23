FactoryGirl.define do

  factory :measurement do
    dataset
    measured_on {Date.new(2013, 1)}
    value 100
  end
  
end