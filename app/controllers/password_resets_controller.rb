class PasswordResetsController < ApplicationController
  skip_authorization_check
  def new
  end

  def create
  user = User.find_by_email(params[:email])
  user.send_password_reset
  redirect_to :root, :notice => "Email sent with password reset instructions."
  end

end
