class AccountsController < ApplicationController
  skip_before_action :set_tenant
  skip_before_action :authenticate_tenant!
  before_action :set_account, only: %i[ show edit update destroy choose]
  
  # GET /accounts or /accounts.json
  def index
    @accounts = current_user.accounts
    @url = request.protocol + request.host_with_port
    @subdomain = request.subdomain
  end

  def select 
    current_user.update(current_tenant_id: params[:id])
    redirect_to boxes_path
  end

end
