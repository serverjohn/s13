class CheckoutsController < ApplicationController
  # GET /checkouts
  # GET /checkouts.xml
  load_and_authorize_resource
  
  def index
    
    # New Check Out
    @checkout = Checkout.new
    @worked_with_types = WorkedWithType.where(active: "Y") # All active worked with types
    @territories = territories # Method for listing territories oldest first
    @publishers = publishers # Method for listing publishers in alphabetical order


    # Check Outs List
    @checkouts = Checkout.all
    @publisers = Publisher.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checkouts }
    end
  end

  # GET /checkouts/1
  # GET /checkouts/1.xml
  def show
    @checkout = Checkout.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @checkout }
    end
  end

  # GET /checkouts/new
  # GET /checkouts/new.xml
  def new
    @checkout = Checkout.new
    @worked_with_types = WorkedWithType.where(active: "Y")

    @territories = territories # Method for listing territories oldest first
    
    @publishers = publishers # Method for listing publishers in alphabetical order

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @checkout }
    end
  end

  # GET /checkouts/1/edit
  def edit
    @checkout = Checkout.find(params[:id])
  end

  # POST /checkouts
  # POST /checkouts.xml
  def create
    puts "+++++++++++++++++++"
    puts params[:checkout].inspect
    puts "+++++++++++++++++++"
    params[:checkout][:territory_type_id] = Territory.find(params[:checkout][:territory_id]).territory_type_id
    @checkout = Checkout.new(params[:checkout])

    respond_to do |format|
      if @checkout.save
        format.html { redirect_to(@checkout, :notice => 'Checkout was successfully created.') }
        format.xml  { render :xml => @checkout, :status => :created, :location => @checkout }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @checkout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /checkouts/1
  # PUT /checkouts/1.xml
  def update
    @checkout = Checkout.find(params[:id])

    respond_to do |format|
      if @checkout.update_attributes(params[:checkout])
        format.html { redirect_to(@checkout, :notice => 'Checkout was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @checkout.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /checkouts/1
  # DELETE /checkouts/1.xml
  def destroy
    @checkout = Checkout.find(params[:id])
    @checkout.destroy

    respond_to do |format|
      format.html { redirect_to(checkouts_url) }
      format.xml  { head :ok }
    end
  end

  def territories
    @territories = Territory.where(active: "Y")
    last_checked_in = []
    @territories.each do |t|
      if Checkout.order("checked_in ASC").where("checked_in IS NOT NULL AND territory_id = #{t.id}").first
        last_checked_in << t.name
      end
    end
      

    @territories = []
    
    
    # Find oldest territory that is checked in
    oldest_checked_in = Checkout.order("checked_out ASC").where("checked_in IS NOT NULL").first
    oci_name = Territory.find(oldest_checked_in.territory.id)
    @territories << [ "Oldest Territory: #{TerritoryType.find(oldest_checked_in.territory_id).name.titleize} - #{oci_name.name}", oldest_checked_in.territory_id ]

    territory_types = TerritoryType.where(active: "Y")
    territories_bt = []
    territory_types.each do |tt|
      oldest_by_type = Checkout.order("checked_in ASC").where("checked_in IS NOT NULL AND territory_type_id = #{tt.id}").first
      next if oldest_by_type == nil
      obt_name = Territory.find(oldest_by_type.territory_id)
      territories_bt << [ "Oldest: #{tt.name.titleize} - #{obt_name.name}", oldest_by_type.territory_id ]
    end
    
    @territories = @territories + territories_bt.sort
    
    territories_all = []
    territories = Territory.where(active: "Y")
    territories.each do |t|
      territory_type_name = TerritoryType.find(t.territory_type_id).name.titleize
      territories_all << [ "#{territory_type_name} - #{t.name}", t.id ]
    end
    
    @territories = @territories + territories_all.sort
  end

  def publishers # List Publishers
    @publishers = Publisher.where(active: "Y")
    @publisher_list = []
    @publishers.each do |publisher|
      @publisher_list << [ "#{publisher.last_name}, #{publisher.first_name}", publisher.id ]
    end
    @publisher_list = @publisher_list.sort # Used an array instead of hash because hashes don't sort right
  end

  def to_be_checked_in    
    #@to_be_checked_in = []
    # Once database is complete, i.e. territory_id and worked_with_id IS NOT NULL, territory id and worked with id checks can be removed.
    @to_be_checked_in = Checkout.order("checked_out ASC").where("checked_in IS NULL")
    #to_be_checked_in.each do |c|
    #  @to_be_checked_in << [ "#{c.territory_type.name} - #{c.territory.name}", c.id ]
    #end
    
    return @to_be_checked_in
  end

end

# class Array
# def stable_sort
      # n = 0
      # sort_by {|x| n+= 1; [x, n]}
# end
# end