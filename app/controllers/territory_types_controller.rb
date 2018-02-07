class TerritoryTypesController < ApplicationController
  load_and_authorize_resource

  def territory_type_params
    params.require(:territory_type).permit(:name, :active, :congregation_id)
  end
  
  # GET /territory_types
  # GET /territory_types.xml
  def index
    @territory_type = TerritoryType.where(congregation_id: "#{current_user.congregation_id}" )

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

  def disable
    @territory_type = TerritoryType.find(params[:format])
    if @territory_type.active == "Y" 
      if @territory_type.update(active: "N")
        redirect_to(territory_types_path, :notice => "#{@territory_type.name.titleize} was disabled.")
      else
        render :action => "edit"
      end
    else
      redirect_to(territory_types_path, :alert => "#{@territory_type.name.titleize} has already been disabled.")
    end
  end

  def enable
    @territory_type = TerritoryType.find(params[:format])
    if @territory_type.active == "N" 
      if @territory_type.update(active: "Y")
        redirect_to(territory_types_path, :notice => "#{@territory_type.name.titleize} was enabled.")
      else
        render :action => "edit"
      end
    else
      redirect_to(territory_types_path, :alert => "#{@territory_type.name.titleize} is already enabled.")
    end
  end

end
