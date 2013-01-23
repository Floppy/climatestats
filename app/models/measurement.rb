class Measurement < ActiveRecord::Base
  belongs_to :dataset
  attr_accessible :measured_on, :value

  validates :value,       :presence => true
  validates :measured_on, :presence => true
  #validates :measured_on, :uniqueness => {:scope => [:dataset]}
  
  after_create :tweet

  # Only tweet by default in production mode
  @@enable_tweets = Rails.env.production?

  def self.enable_tweets=(value)
    @@enable_tweets = value
  end

  def measurement_for_comparison
    dataset.measurements.where(:measured_on => measured_on - dataset.compare_to.months).first
  end
  
  def textual_description
    # Create tweet
    text = "#{dataset.fullname} in #{measured_on.strftime("%B %Y")} were #{value}#{dataset.units}"
    # Add comparison string        
    previous = measurement_for_comparison
    if measurement_for_comparison
      difference = value - previous.value
      direction = difference < 0 ? "down" : "up";
      percentage = (difference.abs / previous.value) * 100
      text += ", #{direction} #{sprintf("%.2f", difference)}#{dataset.units} (#{sprintf("%.1f", percentage)}%) from #{dataset.compare_to} #{dataset.compare_to == 1 ? 'month' : 'months'} earlier."
    end
    text
  end
  
  def tweet
    if @@enable_tweets == true
      logger.info "Measurement: tweeting..."
      Twitter.update(ActionView::Base.full_sanitizer.sanitize(textual_description))
    end
  end

end