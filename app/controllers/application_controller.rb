class ApplicationController < ActionController::Base
  ### work around to get cancan to work. http://stackoverflow.com/questions/17335329/activemodelforbiddenattributeserror-when-creating-new-user
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  ###
  
  WillPaginate.per_page = 10

  include Authentication
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  check_authorization # CanCan - Make sure everything is protected
end
