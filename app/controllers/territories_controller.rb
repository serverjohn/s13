class TerritoriesController < ApplicationController
  load_and_authorize_resource

  def territory_params
    params.require(:territory).permit(:name, :maps, :description, :notes, :active, :territory_type_id)
  end

  helper_method :sort_column, :sort_direction, :territory_types

  # List territories
  def index
#    if params[:search]
#      @territories = Territory.where("name LIKE ?", params[:search]).paginate(:per_page => 10, :page => params[:page])
#    else
#      @territories = Territory.all(:order => sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
#    end
    
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
    respond_to do |format|
     if @territory.save
      format.html { redirect_to(@territory, :notice => 'Territory was successfully created.') }
      else
       render :action => 'new'
     end
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

  # Delete territory.
  # Change this to make in active.
  def destroy
    @territory = Territory.find(params[:id])
    @territory.destroy

    respond_to do |format|
      format.html { redirect_to(territories_url) }
      format.xml  { head :ok }
    end
  end
  
  # Gather Territory Type names and return them.
  def territory_types 
    territory_types = []
    territory_types_tmp = TerritoryType.where(active: "Y")
    
    territory_types_tmp.each do |tt|
      territory_types << [tt.name.titleize,tt.id]
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
