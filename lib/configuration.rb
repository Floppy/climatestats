require 'yaml'

class Configuration
  
  def self.datasets
    load
    @@configs
  end
  
  def self.twitter
    load
    @@twitter_config
  end
  
  def self.load
    all_configs = YAML.load_file("#{File.dirname(__FILE__)}/../config/config.yml")
    @@configs = all_configs['datasets']
    @@twitter_config = all_configs['twitter']
  end
  
end