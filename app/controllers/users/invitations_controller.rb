class Users::InvitationsController < Devise::InvitationsController
  skip_before_action :authenticate_tenant!
end