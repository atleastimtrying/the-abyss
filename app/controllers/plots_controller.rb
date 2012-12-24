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

  # GET /plots/1/edit
  def edit
    @plot = Plot.find(params[:id])
  end

  # POST /plots
  # POST /plots.json
  def create
    @plot = Plot.new(params[:plot])

    respond_to do |format|
      if @plot.save
        format.html { redirect_to @plot, notice: 'Plot was successfully created.' }
        format.json { render json: @plot, status: :created, location: @plot }
      else
        format.html { render action: "new" }
        format.json { render json: @plot.errors, status: :unprocessable_entity }
      end
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
