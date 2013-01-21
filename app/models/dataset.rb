class Dataset < ActiveRecord::Base
  attr_accessible :compare_to, :data_column, :data_uri, :fullname, :info_uri, :month_column, :shortname, :units, :year_column
  has_many :measurements
end
