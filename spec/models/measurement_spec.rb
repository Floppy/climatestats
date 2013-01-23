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
