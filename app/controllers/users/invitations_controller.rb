class Users::InvitationsController < Devise::InvitationsController
  skip_before_action :set_tenant
  skip_before_action :authenticate_tenant!
end