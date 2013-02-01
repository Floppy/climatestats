class DatasetsController < ApplicationController
  def index
    @datasets = Dataset.all
  end

  def show
    # Load dataset
    @dataset = Dataset.where(:stub => params[:id]).first
    raise ActiveRecord::RecordNotFound if @dataset.nil?
    # Put measurements into graph format
    @graphdata = @dataset.measurements.map{|m| {x: m.measured_on.to_time.to_i*1000, y: m.value}}
  end
end
