class HomeController < ApplicationController
  def index
    @plot = Plot.first
  end

  def login
    @user = User.where(:email=>params[:email]).where(:user_name=>params[:password]).first
    render json: @user
  end
  
  def signup
    @user = User.create!({
      :email => params[:email], 
      :user_name => params[:password]
    })
    render json: @user
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
