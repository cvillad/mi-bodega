class ApplicationController < ActionController::Base
  include UrlHelper, DateHelper
  before_action :authenticate_user!
  set_current_tenant_by_subdomain(:account, :subdomain)
  before_action :authenticate_tenant!

  def authenticate_tenant!
    if !current_user.accounts.exists?(current_tenant&.id)
      flash[:alert] = request.subdomain.empty? ? "Select an account first" : "You're not a member of the selected account" 
      redirect_to accounts_path
    end
  end

  def current_member
    @current_member||=current_tenant.members.find_by_user_id(current_user.id)
  end

  def after_accept_path_for(resource)
    accounts_path
  end

  def after_sign_in_path_for(resource)
    accounts_path
  end

  def after_sign_out_path_for(resource_or_scope)
    subdomain = request.subdomain
    url = request.protocol + request.host_with_port
    change_subdomain(url, subdomain, "")
  end
end
