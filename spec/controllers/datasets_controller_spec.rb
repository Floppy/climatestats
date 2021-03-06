require 'spec_helper'

describe DatasetsController do

  context 'listing datasets' do

    before :all do
      DatabaseCleaner.start
      # Setup
      @d = FactoryGirl.create(:dataset)
    end
    
    describe "GET 'index'" do
      it "returns http success" do
        get 'index'
        assigns(:datasets).should_not be_empty
      end
    end

    after :all do
      DatabaseCleaner.clean
    end

  end

  context 'when requesting a valid dataset' do

    before :all do
      DatabaseCleaner.start
      # Setup
      @d = FactoryGirl.create(:dataset)
      @m = FactoryGirl.create(:measurement, :dataset => @d)
    end

    describe "GET 'show'" do
      it "returns http success" do
        # Test result
        get 'show', :id => "global_co2"
        response.should be_success
        # Test variable assignment
        assigns(:dataset).should             == @d
        assigns(:graphdata).length.should    == 1
        assigns(:graphdata).first[:x].should == 1356998400000
        assigns(:graphdata).first[:y].should == 100
      end
    end
    
    after :all do
      DatabaseCleaner.clean
    end

  end

  context 'when requesting an invalid dataset' do

    describe "GET 'show'" do
      it "raises RecordNotFound" do
        expect {
          get 'show', :id => "global_co2"
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
    
  end

end
