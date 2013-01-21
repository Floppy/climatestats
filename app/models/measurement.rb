class Measurement < ActiveRecord::Base
  belongs_to :dataset
  attr_accessible :measured_on, :value
end
