class DatasetsController < ApplicationController
  def index
  end

  def show
    @dataset = Dataset.find(params[:id])
    @data_x = @dataset.measurements.map { |m| m.measured_on.to_time.to_i}.to_json.html_safe
    @data_y = @dataset.measurements.map { |m| m.value}.to_json.html_safe
  end
end
