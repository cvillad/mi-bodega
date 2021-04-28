class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  set_current_tenant_through_filter
  before_action :set_tenant
  #before_action :set_member, only: [:show, :edit, :update, :destroy]

  def set_tenant
    set_current_tenant(Member.find(current_user.id).account)
  end
end
