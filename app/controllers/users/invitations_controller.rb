class Users::InvitationsController < Devise::InvitationsController
  skip_before_action :set_tenant
end