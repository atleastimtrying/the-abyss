class ApplicationController < ActionController::Base
  protect_from_forgery
  def getPlot (x, y)
    plot = Plot.where(:x => x).where(:y => y).first
    unless plot
      description = "<p>You have reached the edge of the abyss nothing is here.</p>"
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
