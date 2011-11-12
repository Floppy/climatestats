#!/usr/bin/env ruby

$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'rubygems'
require 'twitter_oauth'
require 'configuration'

client = TwitterOAuth::Client.new(
  :consumer_key     => Configuration.twitter['consumer_key'],
  :consumer_secret  =>  Configuration.twitter['consumer_secret']
)
request_token = client.request_token

puts "#{request_token.authorize_url}\n"
puts "Hit enter when you have completed authorization."
pin = STDIN.readline.chomp

access_token = client.authorize(
  request_token.token,
  request_token.secret,
  :oauth_verifier => pin
)

puts access_token.inspect
