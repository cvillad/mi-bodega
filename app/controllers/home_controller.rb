class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :set_tenant
  skip_before_action :authenticate_tenant!

  def index
    if current_user 
      redirect_to accounts_path, alert: "You are signed in."
    end
  end
end
