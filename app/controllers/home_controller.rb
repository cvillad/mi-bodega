class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :set_tenant
  skip_before_action :authenticate_tenant!

  def index
  end
end
