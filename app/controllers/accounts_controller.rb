class AccountsController < ApplicationController
  skip_before_action :set_tenant
  before_action :set_account, only: %i[ show edit update destroy choose]
  
  # GET /accounts or /accounts.json
  def index
    @accounts = current_user.accounts
  end

  def select 
    current_user.update(current_tenant_id: params[:id])
    redirect_to boxes_path
  end

end
