class TerritoriesController < ApplicationController
  load_and_authorize_resource

  helper_method :sort_column, :sort_direction
  # GET /territories
  # GET /territories.xml
  def index
    if params[:search]
      @territories = Territory.where("name LIKE ?", params[:search]).paginate(:per_page => 10, :page => params[:page])
    else
      @territories = Territory.all(:order => sort_column + " " + sort_direction).paginate(:per_page => 10, :page => params[:page])
    end
    
    @territory_types = TerritoryType.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @territories }
    end
  end

  # GET /territories/1
  # GET /territories/1.xml
  def show
    @territory = Territory.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @territory }
    end
  end

  # GET /territories/new
  # GET /territories/new.xml
  def new
    @territory = Territory.new
    
    @territory_types = []
    territory_types = TerritoryType.where(active: "Y")
    territory_types.each do |tt|
      @territory_types << [tt.name.titleize,tt.id]
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @territory }
    end
  end

  # GET /territories/1/edit
  def edit
    @territory = Territory.find(params[:id])
  end

  # POST /territories
  # POST /territories.xml
  def create
    puts "+++++++++++++++++++"
    puts params[:territory].inspect
    puts "+++++++++++++++++++"

    uploaded_io = params[:territory][:map]
    File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
      file.write(uploaded_io.read)
    end
    params[:territory][:map] = params[:territory][:map].original_filename

    @territory = Territory.new(params[:territory])

    respond_to do |format|
      if @territory.save
        format.html { redirect_to(@territory, :notice => 'Territory was successfully created.') }
        format.xml  { render :xml => @territory, :status => :created, :location => @territory }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @territory.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /territories/1
  # PUT /territories/1.xml
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

  # DELETE /territories/1
  # DELETE /territories/1.xml
  def destroy
    @territory = Territory.find(params[:id])
    @territory.destroy

    respond_to do |format|
      format.html { redirect_to(territories_url) }
      format.xml  { head :ok }
    end
  end

private
  def sort_column
    Territory.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end
end
