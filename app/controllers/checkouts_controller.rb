class CheckoutsController < ApplicationController

  load_and_authorize_resource

  # Set the permited parameters that can be accepted.
  def checkout_params
    params.require(:checkout).permit(:user_id, :territory_id, :publisher_id, :territory_type_id, :worked_with_type_id, :checked_out, :checked_in, :completed_with, :notes, :checkin_user_id, :congregation_id)
  end
 
  def index
    ## Not Needed ## @worked_with_types = WorkedWithType.where(active: "Y") # All active worked with types
    ## Not Needed ## @territories = territories # Method for listing territories oldest first
    ## Not Needed ## @publishers = publishers # Method for listing publishers in alphabetical order

    # Check Outs List
    @checkouts = Checkout.where(congregation_id: "#{current_user.congregation_id}")
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @checkouts }
    end
  end

  def show
    @checkout = Checkout.find(params[:id])
    @publisher = User.find(@checkout.publisher_id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @checkout }
    end
  end

  def new
    @congregation = current_user.congregation_id
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
    @territories = all_territories
  end

  def create
    params[:checkout][:territory_type_id] = Territory.find(params[:checkout][:territory_id]).territory_type_id
    @checkout = Checkout.new(params[:checkout])
    if @checkout.save
      redirect_to @checkout, notice: 'Checkout was successfully created.'
    else
      @territories = territories
      @publishers = publishers
      render action: 'new'
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
    # List territories that are active and from the same congregation
    territories = Territory.where("active = 'Y' AND congregation_id = #{current_user.congregation_id}")
    #territories = Territory.where("active = 'Y' AND congregation_id = 1")

    # Go through each active territory and find the Checkouts with the oldest checked in date and put in check_in array.
    checked_in = []
    territories.each do |t|
      checked_in << Checkout.where("checked_in IS NOT NULL AND congregation_id = #{current_user.congregation_id} AND territory_id = #{t.id}").order(:checked_in).last
    end
    
    # Reject nil items in the array to keep from breaking the next iteration.
    checked_in.reject! {|item| item == nil}
    
    # sort the array of check_out hashes by the checked_in date
    checked_in.sort_by! do |item|
      item.checked_in
    end

    # Gather Checkouts that are currently checked out and remove them from checked_in.
    check_in.each do |item|
      checked_in.reject! {|ci| ci.territory_id == item.territory_id } 
      territories.reject! {|t| t.id == item.territory_id}
    end

    # create array to hold territories.
    @territories = []
    # Go through sorted checked_in array and get territory information
    # Add information to @territories for options for select on new checkouts.
    # Reject any territories in the territories that have already been added to @territories
    checked_in.each do |ci|
      territory = Territory.find(ci.territory_id)
      @territories << ["#{ci.checked_in.strftime("%m/%d/%Y")}, #{territory.name}", "#{ci.territory_id}"]
      territories.reject! {|item| item.id == ci.territory_id}
    end

    territories.sort_by! do |item|
      item.name
    end
    
    territories.each do |t|
      @territories << ["#{t.name}", "#{t.id}"]
    end

    if @territories.empty?
      @territories << ["None Available", ""]
    end
    @territories
    # convert to array for options for select
    #territories_for_select =[]
    #checked_in_and_not_checked_out.each do |t|
    #  territories_for_select << ["#{Territory.find(t.territory_id).name}",t.territory_id]
    #end

    # Remove multiples
    #territories = territories - territories_from_checkouts

    

    # oci_name = Territory.find(oldest_checked_in.territory.id)
    # @territories << [ "Oldest Territory: #{TerritoryType.find(oldest_checked_in.territory_id).name.titleize} - #{oci_name.name}", oldest_checked_in.territory_id ]

    # territory_types = TerritoryType.where(active: "Y")
    # territories_bt = []
    # territory_types.each do |tt|
    #   oldest_by_type = Checkout.order("checked_in ASC").where("checked_in IS NOT NULL AND territory_type_id = #{tt.id}").first
    #   next if oldest_by_type == nil
    #   obt_name = Territory.find(oldest_by_type.territory_id)
    #   territories_bt << [ "Oldest: #{tt.name.titleize} - #{obt_name.name}", oldest_by_type.territory_id ]
    # end
    
    # @territories = @territories + territories_bt.sort
    
    # territories_all = []
    # territories = Territory.where(active: "Y")
    # territories.each do |t|
    #   territory_type_name = TerritoryType.find(t.territory_type_id).name.titleize
    #   territories_all << [ "#{territory_type_name} - #{t.name}", t.id ]
    # end
    
  end
  def all_territories
    all_territories = Territory.where("congregation_id = #{current_user.congregation_id}")
    territories_list = []
    all_territories.each do |territory|
      territories_list << [ territory.name, territory.id ]
    end
    all_territories = territories_list.sort
    return all_territories
  end
  def publishers # List Publishers
    @publishers = User.where(active: "Y", congregation_id: "#{current_user.congregation_id}")
    @publisher_list = []
    @publishers.each do |publisher|
      @publisher_list << [ "#{publisher.last_name}, #{publisher.first_name}", publisher.id ]
    end
    @publisher_list = @publisher_list.sort # Used an array instead of hash because hashes don't sort right
  end

  def check_in
    # Gather checkouts not checked in.
    @check_in = Checkout.order("checked_out ASC").where("checked_in IS NULL AND congregation_id = #{current_user.congregation_id}")
  end

end
