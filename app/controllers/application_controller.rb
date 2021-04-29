class ApplicationController < ActionController::Base
  include UrlHelper
  before_action :authenticate_user!
  set_current_tenant_by_subdomain(:account, :subdomain)
  before_action :authenticate_tenant!

  def authenticate_tenant!
    if !current_user.accounts.exists?(current_tenant&.id)
      flash[:alert] = "You are not a member of this account"
      redirect_to accounts_path
    end
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
