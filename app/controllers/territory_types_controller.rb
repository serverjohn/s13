class TerritoryTypesController < ApplicationController
  load_and_authorize_resource

  def territory_type_params
    params.require(:territory_type).permit(:name, :active)
  end
  
  # GET /territory_types
  # GET /territory_types.xml
  def index
    @territory_type = TerritoryType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @territory_type }
    end
  end

  # GET /territory_types/1
  # GET /territory_types/1.xml
  def show
    @territory_type = TerritoryType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @territory_type }
    end
  end

  # GET /territory_types/new
  # GET /territory_types/new.xml
  def new
    @territory_type = TerritoryType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @territory_type }
    end
  end

  # GET /territory_types/1/edit
  def edit
    @territory_type = TerritoryType.find(params[:id])
  end

  # POST /territory_types
  # POST /territory_types.xml
  def create
    @territory_type = TerritoryType.new(params[:territory_type])

    respond_to do |format|
      if @territory_type.save
        format.html { redirect_to(@territory_type, :notice => 'Territory Type successfully created') }
        format.xml  { render :xml => @territory_type, :status => :created, :location => @territory_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @territory_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @territory_type = TerritoryType.find(params[:id])

    respond_to do |format|
      if @territory_type.update_attributes(params[:territory_type])
        format.html { redirect_to(@territory_type, :notice => 'The territory type was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @territory_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @territory_type = TerritoryType.find(params[:id])
    @territory_type.destroy

    respond_to do |format|
      format.html { redirect_to(territory_types_url) }
      format.xml  { head :ok }
    end
  end
  
end
