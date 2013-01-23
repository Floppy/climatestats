require 'spec_helper'

describe Measurement do
  
  context 'testing validations' do
    before :all do
      #DatabaseCleaner.start
      @dataset = FactoryGirl.create :dataset
      @measurement = FactoryGirl.create :measurement, :dataset => @dataset
    end
    
    it 'should have a unique date within a dataset' do
      pending 're-adding the date validation breaks FactoryGirl for some reason'
      m = FactoryGirl.create :measurement, :dataset => @dataset, :measured_on => @measurement.measured_on
      m.should_not be_valid
      puts m.errors.inspect
    end
    
    after :all do
      #DatabaseCleaner.clean
    end
  end

  context 'sending tweets' do

    it 'should send a tweet when created' do
      pending
    end
    
    it 'should not send a tweet if invalid' do
      pending
    end
    
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

  context 'comparing back a year' do

    before :all do
      #DatabaseCleaner.start
      @dataset = FactoryGirl.create :dataset
      m = FactoryGirl.create :measurement, :dataset => @dataset, :value => 110.0
      FactoryGirl.create :measurement, :dataset => @dataset, :measured_on => m.measured_on - 12.months
    end
    
    it 'should generate a valid text description' do
      @dataset.measurements.last.measurement_for_comparison.should be_present
      @dataset.measurements.last.textual_description.should == 'Global CO<sub>2</sub> levels in January 2013 were 110.0ppm, up 10.00ppm (10.0%) from 12 months earlier.'
    end
    
    after :all do
      #DatabaseCleaner.clean
    end

  end

  context 'comparing back a month' do

    before :all do
      #DatabaseCleaner.start
      @dataset = FactoryGirl.create :dataset_monthly
      m = FactoryGirl.create :measurement, :dataset => @dataset, :value => 110.0
      FactoryGirl.create :measurement, :dataset => @dataset, :measured_on => m.measured_on - 1.month
    end
    
    it 'should generate a valid text description' do
      @dataset.measurements.last.measurement_for_comparison.should be_present
      @dataset.measurements.last.textual_description.should == 'Seasonally-corrected global CO<sub>2</sub> levels in January 2013 were 110.0ppm, up 10.00ppm (10.0%) from 1 month earlier.'
    end
    
    after :all do
      #DatabaseCleaner.clean
    end

  end

end
