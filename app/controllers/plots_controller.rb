class PlotsController < ApplicationController
  # GET /plots
  # GET /plots.json
  def index
    @plots = Plot.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plots }
    end
  end

  # GET /plots/1
  # GET /plots/1.json
  def show
    @plot = Plot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plot }
    end
  end

  # GET /plots/new
  # GET /plots/new.json
  def new
    @plot = Plot.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plot }
    end
  end

  # GET /plots/fetch
  def fetch
    x = params[:x].to_i
    y = params[:y].to_i
    plot = getPlot x, y
    north = getPlot x, (y.to_i + 1)
    south = getPlot x, (y.to_i - 1)
    east = getPlot (x.to_i - 1), y
    west = getPlot (x.to_i + 1), y
    respond_to do |format|
      format.json { 
        render json: {
          :plot => plot, 
          :north => north, 
          :south => south, 
          :east => east, 
          :west => west
        } 
      }
    end
  end

  # GET /plots/1/edit
  def edit
    @plot = Plot.find(params[:id])
  end

  # POST /plots
  # POST /plots.json
  def create
    if current_user
      current_user.plots.build({ 
        :x => params[:x], 
        :y => params[:y],
        :title => params[:title],
        :description => params[:description]
      })
      render json: @plot
    else
      render json: {
        :error => 'not logged in!'
      }
    end
  end

  # PUT /plots/1
  # PUT /plots/1.json
  def update
    @plot = Plot.find(params[:id])

    respond_to do |format|
      if @plot.update_attributes(params[:plot])
        format.html { redirect_to @plot, notice: 'Plot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @plot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plots/1
  # DELETE /plots/1.json
  def destroy
    @plot = Plot.find(params[:id])
    @plot.destroy

    respond_to do |format|
      format.html { redirect_to plots_url }
      format.json { head :no_content }
    end
  end
end
