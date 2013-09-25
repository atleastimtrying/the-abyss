class HomeController < ApplicationController
  def index
  end
  def grid
    @plots = Plot.all
  end
end
