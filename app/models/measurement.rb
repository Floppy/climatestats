class Measurement < ActiveRecord::Base
  belongs_to :dataset
  attr_accessible :measured_on, :value
  validates :measured_on, :uniqueness, :scope => [:dataset]
  
  after_create :tweet

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
      text += ", #{direction} #{sprintf("%.2f", difference)}#{dataset.units} (#{sprintf("%.1f", percentage)}%) from #{dataset.compare_to.months} months earlier."
    end
  end
  
  def tweet
    logger.info "Measurement: tweeting..."
    # Post
    Twitter.update(textual_description)
  end

end