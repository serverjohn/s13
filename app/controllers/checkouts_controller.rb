class CheckoutsController < ApplicationController

  load_and_authorize_resource

  # Set the permited parameters that can be accepted.
  def checkout_params
    params.require(:checkout).permit(:user_id, :territory_id, :publisher_id, :territory_type_id, :worked_with_type_id, :checked_out, :checked_in, :completed_with, :notes, :checkin_user_id, :congregation_id)
  end
 
  def index
    # New Check Out
    @checkout = Checkout.new
    @worked_with_types = WorkedWithType.where(active: "Y") # All active worked with types
    @territories = territories # Method for listing territories oldest first
    @publishers = publishers # Method for listing publishers in alphabetical order


    # Check Outs List
    @checkouts = Checkout.all
    @publisers = User.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checkouts }
    end
  end

  # GET /checkouts/1
  # GET /checkouts/1.xml
  def show
    @checkout = Checkout.find(params[:id])
    @publisher = User.find(@checkout.publisher_id)
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

  def edit
    @checkout = Checkout.find(params[:id])
    @publishers = publishers
  end

  def create
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

  def update
    if Checkout.find(params[:id]).checked_in.nil?
      @checkout = Checkout.find(params[:id])
      @checkout.checkin_user_id = current_user.id
    else
      @checkout = Checkout.find(params[:id])
    end
    
    

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

  def disable
    @checkout = Checkout.find(params[:format])
    if @checkout.active == "Y" 
      if @checkout.update(active: "N")
        redirect_to(checkouts_path, :notice => "#{@checkout.name.titleize} was disabled.")
      else
        render :action => "edit"
      end
    else
      redirect_to(checkouts_path, :alert => "#{@checkout.name.titleize} has already been disabled.")
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
    @publishers = User.where(active: "Y")
    @publisher_list = []
    @publishers.each do |publisher|
      @publisher_list << [ "#{publisher.last_name}, #{publisher.first_name}", publisher.id ]
    end
    @publisher_list = @publisher_list.sort # Used an array instead of hash because hashes don't sort right
  end

  def checkin
    # Gather checkouts not checked in.
    @checkins = Checkout.order("checked_out ASC").where("checked_in IS NULL")
  end

end
