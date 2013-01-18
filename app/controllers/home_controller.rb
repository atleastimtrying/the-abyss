class HomeController < ApplicationController
  def index
    @plot = Plot.first
  end

  def newplot
    @plot = Plot.create!({ 
      :x => params[:x], 
      :y => params[:y],
      :user_id => params[:user_id],
      :title => params[:title],
      :description => params[:description]
    })
    render json: @plot
  end
end
