class HomeController < ApplicationController
  def index
    @plot = getPlot 0, 0
    @north_title = getPlot(0, 1)[:title]
    @south_title = getPlot(0, -1)[:title]
    @east_title = getPlot(-1, 0)[:title]
    @west_title = getPlot(1, 0)[:title]
  end
  def grid
    @plots = Plot.all
  end
end
