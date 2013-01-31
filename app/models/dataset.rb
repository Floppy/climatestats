require 'open-uri'
require 'csv'

class Dataset < ActiveRecord::Base
  attr_accessible :compare_to, :data_column, :data_uri, :fullname, :info_uri, :month_column, :shortname, :units, :year_column
  has_many :measurements, :order => :measured_on
  
  validates :stub, :presence => true
  validates :shortname, :presence => true 
  validates :fullname, :presence => true 
  validates :data_uri, :presence => true 
  validates :info_uri, :presence => true 
  validates :year_column, :presence => true 
  validates :month_column, :presence => true 
  validates :data_column, :presence => true 
  validates :compare_to, :presence => true 
  validates :units, :presence => true 
    
  def update
    # Get data
    logger.info "Dataset: fetching data for #{shortname}"
    rawdata = open(data_uri).read
    # Parse datafile
    logger.info "Dataset: parsing data"
    CSV.parse(rawdata, :col_sep => ' ') do |row|
      # Dump comments
      unless row[0] == '#'
        # Dump empty fields
        row.delete_if { |item| item.nil? }
        # Create new measurement
        measurements.create(:measured_on => Date.new(row[year_column].to_i, row[month_column].to_i), :value => row[data_column.to_f])
      end
    end
  end
  
  def to_param
    stub
  end

end