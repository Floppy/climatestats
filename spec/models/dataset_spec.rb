require 'spec_helper'

describe Dataset do

  it 'should use stub as param' do
    d = FactoryGirl.build(:dataset)
    d.to_param.should == "global_co2"
  end
  
  context 'valid objects' do
  
    it 'must have a stub' do
      d = FactoryGirl.build(:dataset, :stub => nil)
      d.should_not be_valid
    end
  
    it 'must have a shortname' do
      d = FactoryGirl.build(:dataset, :shortname => nil)
      d.should_not be_valid
    end

    it 'must have a fullname' do
      d = FactoryGirl.build(:dataset, :fullname => nil)
      d.should_not be_valid
    end

    it 'must have a data_uri' do
      d = FactoryGirl.build(:dataset, :data_uri => nil)
      d.should_not be_valid
    end

    it 'must have a info_uri' do
      d = FactoryGirl.build(:dataset, :info_uri => nil)
      d.should_not be_valid
    end

    it 'must have a year_column' do
      d = FactoryGirl.build(:dataset, :year_column => nil)
      d.should_not be_valid
    end

    it 'must have a month_column' do
      d = FactoryGirl.build(:dataset, :month_column => nil)
      d.should_not be_valid
    end

    it 'must have a data_column' do
      d = FactoryGirl.build(:dataset, :data_column => nil)
      d.should_not be_valid
    end

    it 'must have a compare_to' do
      d = FactoryGirl.build(:dataset, :compare_to => nil)
      d.should_not be_valid
    end

    it 'must have units' do
      d = FactoryGirl.build(:dataset, :units => nil)
      d.should_not be_valid
    end
    
  end

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
