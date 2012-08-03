class CablesController < ApplicationController
  helper_method :sort_column, :sort_direction
  before_filter :authenticate_user!
  
  # GET /cables
  # GET /cables.json
  def index
    @cables = Cable
      .search(params[:search])
      .order(sort_column + ' ' + sort_direction)
      .where(sort_facet)
    
    @facets = FacetProc.calculate(@cables) do |column_relevancy|
      column_relevancy[:type] = 1
    end
    
    @cables = @cables.paginate(per_page: 25, page: params[:page])
    
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
    authorize! :create, @cable
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @cable }
    end
  end

  # GET /cables/1/edit
  def edit
    @cable = Cable.find(params[:id])
    authorize! :edit, @cable
  end

  # POST /cables
  # POST /cables.json
  def create
    @cable = Cable.new(params[:cable])
    authorize! :create, @cable

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
    authorize! :update, @cable
    
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
    authorize! :destroy, @cable

    respond_to do |format|
      format.html { redirect_to cables_url }
      format.json { head :no_content }
    end
  end
  
  private
    def sort_column
      Cable.column_names.include?(params[:sort]) ? params[:sort] : "item_number"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
    end
    
    def sort_facet
      params.select{|k,v| Cable.column_names.include? k.to_s }
    end
end
