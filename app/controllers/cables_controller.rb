class CablesController < ApplicationController
  # GET /cables
  # GET /cables.json
  def index
    @cables = Cable.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @cables }
    end
  end

  # GET /cables/1
  # GET /cables/1.json
  def show
    @cable = Cable.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @cable }
    end
  end

  # GET /cables/new
  # GET /cables/new.json
  def new
    @cable = Cable.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cable }
    end
  end

  # GET /cables/1/edit
  def edit
    @cable = Cable.find(params[:id])
  end

  # POST /cables
  # POST /cables.json
  def create
    @cable = Cable.new(params[:cable])

    respond_to do |format|
      if @cable.save
        format.html { redirect_to @cable, notice: 'Cable was successfully created.' }
        format.json { render json: @cable, status: :created, location: @cable }
      else
        format.html { render action: "new" }
        format.json { render json: @cable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /cables/1
  # PUT /cables/1.json
  def update
    @cable = Cable.find(params[:id])

    respond_to do |format|
      if @cable.update_attributes(params[:cable])
        format.html { redirect_to @cable, notice: 'Cable was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @cable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cables/1
  # DELETE /cables/1.json
  def destroy
    @cable = Cable.find(params[:id])
    @cable.destroy

    respond_to do |format|
      format.html { redirect_to cables_url }
      format.json { head :no_content }
    end
  end
end
