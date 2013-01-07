class HomeController < ApplicationController
  def index
    @user = User.new
    @plot = Plot.first
  end
end
