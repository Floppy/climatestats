#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'rubygems'
require 'open-uri'
require 'csv'
require 'date'
require 'twitter'
require 'configuration'

def main
  # Get config file
  load_state
  # For each configuration
  Configuration.datasets.each_pair do |name, config|
    # Get data
    print "fetching data\n"
    rawdata = open(config['data_uri']).read
    # Parse datafile
    print "parsing data\n"
    data = parse(rawdata)
    # Check if data feed has been updated
    latest_year = data.last[config['year_col']].to_i
    latest_month = data.last[config['month_col']].to_i
    unless @@state and @@state[name] and latest_year == @@state[name]['year'] and latest_month == @@state[name]['month']
      # Send updates
      @@state = {} unless @@state
      @@state[name] = {}
      @@state[name]['year'] = latest_year
      @@state[name]['month'] = latest_month
      print "sending updates\n"
      # Twitter
      send_update_to_twitter(data, name, config)
    end
    save_state
  end
end

def load_state
  @@state = YAML.load_file("#{File.dirname(__FILE__)}/../data/state.yml") rescue nil
end

def save_state
  File.open("#{File.dirname(__FILE__)}/../data/state.yml", 'w') do |out|
   YAML.dump(@@state, out)
  end
end

def parse(rawdata)
  data = []
  CSV::Reader.parse(rawdata, ' ') do |row|
    # Dump comments
    unless row[0] == '#'
      # Dump empty fields
      row.delete_if { |item| item.nil? }
      # Store row in array
      data << row unless row.empty?
    end
    
  end
  return data
end

def send_update_to_twitter(data, config_name, config)  
  print "twittering... "
  if Configuration.twitter.nil? or Configuration.twitter[config_name].nil?
    print "not configured\n"
  else
    # Get config data
    y = config['year_col']
    m = config['month_col']
    # For each tweet in the current configuration
    Configuration.twitter[config_name].each do |tweet|
      col = tweet['data_col']
      # Create tweet
      current = data.last
      previous = data[data.length - (tweet['compare_months_back'].to_i+1)]
      date = Date.new(current[y].to_i, current[m].to_i, 1)
      difference = current[col].to_f - previous[col].to_f
      direction = difference < 0 ? "down" : "up";
      percentage = (difference.abs / previous[col].to_f) * 100
      tweet = "#{tweet['prefix']} in #{date.strftime("%B %Y")} were #{current[col]}ppm, #{direction} #{sprintf("%.2f", difference)}ppm (#{sprintf("%.1f", percentage)}%) from #{tweet['suffix']}."
      # Post
      Twitter.configure do |config|
        config.consumer_key = Configuration.twitter['consumer_key']
        config.consumer_secret = Configuration.twitter['consumer_secret']
        config.oauth_token = Configuration.twitter['oauth_token']
        config.oauth_token_secret = Configuration.twitter['oauth_secret']
      end
      Twitter.update(tweet)
    end
    print "OK\n"
  end
end

# Run
main