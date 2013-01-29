require 'spec_helper'

describe DatasetsController do

  describe "GET 'index'" do
    it "returns http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'show'" do
    it "returns http success" do
      FactoryGirl.create(:dataset)
      get 'show', :id => 1
      response.should be_success
    end
  end

end
