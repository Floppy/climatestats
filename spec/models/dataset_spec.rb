require 'spec_helper'

describe Dataset do
  
  context 'importing new data' do
    
    before :all do
      DatabaseCleaner.start
      @dataset = FactoryGirl.create :dataset
    end
    
    it 'should import data from file correctly' do
      # Set up webmock stub so we don't really do a fetch
      @dataset.should_receive(:open).with("ftp://ftp.cmdl.noaa.gov/ccg/co2/trends/co2_mm_gl.txt").and_return(File.open(File.join(Rails.root, 'spec', 'fixtures', 'co2_mm_gl.txt')))
      # Import
      @dataset.update
      # Check measurements
      @dataset.measurements.count.should == 23
      @dataset.measurements.first.measured_on.should == Date.new(2011,1)
      @dataset.measurements.first.value.should == 390.74
      @dataset.measurements.last.measured_on.should == Date.new(2012,11)
      @dataset.measurements.last.value.should == 393.65
    end
    
    after :all do
      DatabaseCleaner.clean
    end

  end

end
