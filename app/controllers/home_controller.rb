class HomeController < ApplicationController
  def index
  end
  def grid
    @plots = Plot.published
  end
end
