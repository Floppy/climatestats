require 'spec_helper'

describe Measurement do
  
  it 'should have a unique date within a dataset' do
    pending
  end
  
  context 'with nothing to compare to' do

    before :all do
      #DatabaseCleaner.start
      @measurement = FactoryGirl.create :measurement
    end
    
    it 'should generate a valid text description' do
      @measurement.textual_description.should == 'Global CO<sub>2</sub> levels in January 2013 were 100.0ppm'
    end
    
    after :all do
      #DatabaseCleaner.clean
    end

  end

end
