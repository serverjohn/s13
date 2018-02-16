class TerritoriesController < ApplicationController
  load_and_authorize_resource

  def territory_params
    params.require(:territory).permit(:name, :maps, :description, :notes, :active, :territory_type_id, :congregation_id)
  end

  helper_method :sort_column, :sort_direction, :territory_types

  # List territories
  def index 
    @territory_types = TerritoryType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @territories }
    end
  end

  # Show Territory
  def show
    @territory = Territory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @territory }
    end
  end

  # New territory
  def new
    @territory = Territory.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @territory }
    end
  end

  # Edit territory
  def edit
    @territory = Territory.find(params[:id])
    @territory_types = territory_types
  end

  # Create territories
  def create
    if params[:territory][:maps] # Determine if the maps parameter has been set. Then save it. 
      uploaded_io = params[:territory][:maps]
      File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
        file.write(uploaded_io.read)
      end
      params[:territory][:maps] = params[:territory][:maps].original_filename
    end

    @territory = Territory.new(params[:territory])
    
    if @territory.save
      redirect_to @territory, notice: 'Territory was successfully created.'
    else
     render action: 'new'
    end
  end
   
  # Update territory
  def update
    @territory = Territory.find(params[:id])

    respond_to do |format|
      if @territory.update_attributes(params[:territory])
        format.html { redirect_to(@territory, :notice => 'Territory was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @territory.errors, :status => :unprocessable_entity }
      end
    end
  end

  def disable
    @territory = Territory.find(params[:format])
    if @territory.active == "Y" 
      if @territory.update(active: "N")
        redirect_to(territories_path, :notice => "#{@territory.name.titleize} was disabled.")
      else
        render :action => "edit"
      end
    else
      redirect_to(territories_path, :alert => "#{@territory.name.titleize} has already been disabled.")
    end
  end

  def enable
    @territory = Territory.find(params[:format])
    if @territory.active == "N" 
      if @territory.update(active: "Y")
        redirect_to(territories_path, :notice => "#{@territory.name.titleize} was enabled.")
      else
        render :action => "edit"
      end
    else
      redirect_to(territories_path, :alert => "#{@territory.name.titleize} is already enabled.")
    end
  end

  # Gather Territory Type names and return them.
  def territory_types 
    territory_types = []
    territory_types_tmp = TerritoryType.where(active: "Y", congregation_id: "#{current_user.congregation_id}")
    
    territory_types_tmp.each do |tt|
      territory_types << ["#{tt.name.titleize}", tt.id]
    end
    
    return territory_types
  end

private
  def sort_column
    Territory.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
