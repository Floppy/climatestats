[![Build Status](http://jenkins.theodi.org/job/ClimateStats-build-master/badge/icon)](http://jenkins.theodi.org/job/ClimateStats-build-master/)

CO2 Updates: http://github.com/Floppy/co2updates

Author: James Smith

Email : james@floppy.org.uk

Web   : http://www.floppy.org.uk

REQUIREMENTS
============

Ruby 1.8 (not tested with 1.9 yet)

Gems:
-  twitter
-  twitter_oauth

Run bundle to install gems

USAGE
=====

1. Copy config/config_example.yml to config/config.yml.

2. Fill in the consumer key and secret in the twitter config. You can get these
   by setting up an app at https://dev.twitter.com/apps/
   
3. Run bin/oauth.rb and follow the instructions.

4. From the oauth output, put the oauth token and secret into config.yml

5. Run bin/co2_updates.rb, and you're away!

DATA
====

The NOAA data source specified in the default config_example.yml is global mean
CO2 concentration data from http://www.esrl.noaa.gov/gmd/ccgg/trends/#global

Application state is saved into data/state.yml. The latest year and month from
the datafile is stored, and checked against the datafile on each run. If the 
latest date has not changed, updates are not sent out.
