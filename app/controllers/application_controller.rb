class ApplicationController < ActionController::Base
  include DateHelper
  helper_method :current_member
  set_current_tenant_through_filter
  before_action :authenticate_user!
  before_action :set_tenant

  def set_tenant
    account = Account.find(current_user&.current_tenant_id)
    set_current_tenant(account)
  rescue
    redirect_to accounts_path
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
end
