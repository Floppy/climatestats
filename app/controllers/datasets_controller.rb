class DatasetsController < ApplicationController
  def index
  end

  def show
    @dataset = Dataset.find(params[:id])
    @data = @dataset.measurements.map{|m| {x: m.measured_on.to_time.to_i*1000, y: m.value}}
  end
end
