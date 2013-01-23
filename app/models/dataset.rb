class Dataset < ActiveRecord::Base
  attr_accessible :compare_to, :data_column, :data_uri, :fullname, :info_uri, :month_column, :shortname, :units, :year_column
  has_many :measurements, :order => :measured_on
end

def update
  # Get data
  logger.info "Dataset: fetching data for #{shortname}"
  rawdata = open(data_uri).read
  # Parse datafile
  logger.info "Dataset: parsing data"
  CSV::Reader.parse(rawdata, ' ') do |row|
    # Dump comments
    unless row[0] == '#'
      # Dump empty fields
      row.delete_if { |item| item.nil? }
      # Create new measurement
      Measurement.create(:measured_on => Date.new(row[year_column], row[month_column]), :value => row[data_column.to_f])
    end
  end
end