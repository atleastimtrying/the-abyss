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
    x = params[:x].to_i
    y = params[:y].to_i
    plot = getPlot(x, y)
    respond_to do |format|
      format.json { 
        render json: {
          plot: plot, 
          north: getPlot(x, (y + 1)), 
          south: getPlot(x, (y - 1)), 
          east: getPlot((x + 1), y), 
          west: getPlot((x - 1), y),
          items: getItems(x,y)
        } 
      }
    end
  end

  # GET /plots/new
  # GET /plots/new.json
  def new
    @plot = Plot.new(plots_params)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plot }
    end
  end

  # GET /plots/1/edit
  def edit
    @plot = Plot.find(plots_params)
  end

  # POST /create
  # POST /create.json
  def create
    p = Plot.create(plots_params)
    render json: p
  end

  # PUT /plots/1
  # PUT /plots/1.json
  def update
    @plot = Plot.find(plots_params)

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

  private
  
  def plots_params
    params.permit(:x, :y, :title, :description, :north_wall, :south_wall, :east_wall, :west_wall)
  end
end
