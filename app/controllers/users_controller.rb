class UsersController < ApplicationController
  load_and_authorize_resource

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation, :role, :first_name, :last_name, :active)
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
