class TerritoryTypesController < ApplicationController
  load_and_authorize_resource
  
  # GET /publishers
  # GET /publishers.xml
  def index
    @territory_type = TerritoryType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @territory_type }
    end
  end

  # GET /publishers/1
  # GET /publishers/1.xml
  def show
    @territory_type = Territory_type.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @territory_type }
    end
  end

  # GET /publishers/new
  # GET /publishers/new.xml
  def new
    @territory_type = TerritoryType.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @territory_type }
    end
  end

  # GET /publishers/1/edit
  def edit
    @territory_type = TerritoryType.find(params[:id])
  end

  # POST /publishers
  # POST /publishers.xml
  def create
    @publisher = TerritoryType.new(params[:territory_type])

    respond_to do |format|
      if @publisher.save
        format.html { redirect_to(@publisher, :notice => 'Territory Type successfully created') }
        format.xml  { render :xml => @publisher, :status => :created, :location => @territory_type }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @territory_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @territory_type = TerritoryType.find(params[:id])

    respond_to do |format|
      if @publisher.update_attributes(params[:territory_type])
        format.html { redirect_to(@territory_type, :notice => 'Publisher was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @territory_type.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @territory_type = TerritoryTypes.find(params[:id])
    @territory_type.destroy

    respond_to do |format|
      format.html { redirect_to(territory_types_url) }
      format.xml  { head :ok }
    end
  end
  
end
