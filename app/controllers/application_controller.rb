class ApplicationController < ActionController::Base
  protect_from_forgery

  def getPlot (x, y)
    plot = Plot.published.where(:x => x).where(:y => y).first
    unless plot
      description = "You have reached the edge of the abyss nothing is here.<br>"
      description = description + "To change this you can <span class=\"highlight\">write</span> it, just enter <span class=\"highlight\">write</span> as a command then fill out the popup."
      plot = {
        x: x,
        y: y,
        title: 'The Abyss',
        description: description
      }
    end
    plot
  end

  def getItems (x,y)
    Item.all.where(:x => x).where(:y => y)
  end
end
