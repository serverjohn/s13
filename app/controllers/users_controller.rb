class UsersController < ApplicationController
  load_and_authorize_resource

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :role, :first_name, :last_name, :active, :phone_number, :notes, :text_message, :cell_carrier, :congregation_id)
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Thank you for signing up! You are now logged in."
      redirect_to root_url
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
        
        puts "#{months.inspect}"
        puts "#{days_co.inspect}"
        puts "#{days_ci.inspect}"
        @user_history[":#{hist.id}"] = {
          :name => "#{hist.territory.name}",
          :age => "#{months + days_co + days_ci}",
          :checkout => "#{hist.checked_out.strftime("%m-%d-%Y")}",
          :checkin => "#{hist.checked_in.strftime("%m-%d-%Y")}",
          :workedwith => "#{hist.worked_with_type.name}"
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
