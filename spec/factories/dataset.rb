FactoryGirl.define do

  factory :dataset do
    shortname "CO<sub>2</sub> (global)"
    fullname "Global CO<sub>2</sub> levels"
    data_uri "ftp://ftp.cmdl.noaa.gov/ccg/co2/trends/co2_mm_gl.txt"
    info_uri "http://www.esrl.noaa.gov/gmd/ccgg/trends/#global"
    year_column 0
    month_column 1
    data_column 3
    compare_to 12
    units 'ppm'
  end
  
  factory :dataset_monthly, class: Dataset do
    shortname "Seasonally-corrected CO<sub>2</sub> (global)"
    fullname "Seasonally-corrected global CO<sub>2</sub> levels"
    data_uri "ftp://ftp.cmdl.noaa.gov/ccg/co2/trends/co2_mm_gl.txt"
    info_uri "http://www.esrl.noaa.gov/gmd/ccgg/trends/#global"
    year_column 0
    month_column 1
    data_column 4
    compare_to 1
    units 'ppm'
  end

end