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
      description = "You have reached the edge of the abyss nothing is here."
      description = description + "<p class='author'>To change this you can <a href='#' class='modal-launcher inline' data-modal-id='newplot'>write it</a></p>" if current_user
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
