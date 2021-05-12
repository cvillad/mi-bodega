module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_tenant

    def connect
      self.current_tenant = find_verified_tenant
    end

    private
    def find_verified_tenant
      if current_user = env['warden'].user
        Account.find(current_user.current_tenant_id)
      else
        reject_unauthorized_connection
      end
    end
  end
end
