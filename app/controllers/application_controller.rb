class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :dev_authenticate
  
  def dev_authenticate
    if ["staging", "production"].include?(Rails.env)
      authenticate_or_request_with_http_basic do |username, password|
        username == ENV['AUTH_USERNAME'] && password == ENV['AUTH_PASSWORD']
      end
    end
  end

  def getPlot (x, y)
    plot = Plot.where(:x => x).where(:y => y).first
    unless plot
      description = "You have reached the edge of the abyss nothing is here.<br>"
      description = description + "To change this you can write it, just enter write as a command then fill out the popup."
      plot = {
        x: x,
        y: y,
        title: 'The Abyss',
        description: description
      }
    end
    plot
  end
end
