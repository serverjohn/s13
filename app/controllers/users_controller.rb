class UsersController < ApplicationController
  load_and_authorize_resource

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :first_name, :last_name, :active, :phone_number, :notes, :text_message, :cell_carrier, :congregation_id)
  end

  def new
    @user = User.new
    @congregations = congregations
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    
    unless current_user.role == "admin" # Only allows admins to change a congregation.
      @user.congregation = current_user.congregation
    end
    
    if @user.save
      flash[:notice] = "New user created."
      redirect_to users_url
    else
      render :action => 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @territories_checked_out = {}
    # Get history of territories that have been checked out but not checked in.
    Checkout.where(publisher_id: "#{@user.id}").each do |hist|
      if not hist.checked_in
        @territories_checked_out[":#{hist.id}"] = {
            :name => "#{hist.territory.name}",
            :checkedoutat => "#{hist.checked_out.strftime("%m-%d-%Y")}",
            :age_months => "#{ (Date.today.year * 12 + Date.today.month) - (hist.checked_out.year * 12 + hist.created_at.month) }",
          }
        
      end
    end
    
    # Get full history.
    @user_history = {}
    @user.checkouts.each do |hist|
      if hist.checked_in
        months = (hist.checked_in.year * 12 + hist.checked_in.month) - (hist.checked_out.year * 12 + hist.checked_out.month)
        days_co = hist.checked_out.day.to_f / (Time.days_in_month hist.checked_out.month, hist.checked_out.year)
        days_ci = hist.checked_in.day.to_f / (Time.days_in_month hist.checked_in.month) 
        
        @user_history[":#{hist.id}"] = {
          :name => "#{hist.territory.name}",
          :age => "#{months + days_co + days_ci}",
          :checkout => "#{hist.checked_out.strftime("%m-%d-%Y")}",
          :checkin => "#{hist.checked_in.strftime("%m-%d-%Y")}",
          :workedwith => unless hist.worked_with_type.nil? then hist.worked_with_type.name end
        }
      end
    end
  end

  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def disable
    @user = User.find(params[:format])
    if @user.active == "Y" 
      if @user.update(active: "N")
        redirect_to(users_path, :notice => "#{@user.first_name.titleize} #{@user.last_name.titleize} was disabled.")
      else
        render :action => "edit"
      end
    else
      redirect_to(users_path, :alert => "#{@user.first_name.titleize} #{@user.last_name.titleize} has already been disabled.")
    end
  end
end

  def enable
    @user = User.find(params[:format])
    if @user.active == "N" 
      if @user.update(active: "Y")
        redirect_to(users_path, :notice => "#{@user.name.titleize} was enabled.")
      else
        render :action => "edit"
      end
    else
      redirect_to(users_path, :alert => "#{@user.name.titleize} is already enabled.")
    end
  end

  def congregations # List Congregations
    @congregations = Congregation.where(active: "Y")
    @congregation_list = []
    @congregations.each do |congregation|
      @congregation_list << [ "#{congregation.name}", congregation.id ]
    end
    @congregation_list = @congregation_list.sort # Used an array instead of hash because hashes do not sort right
  end