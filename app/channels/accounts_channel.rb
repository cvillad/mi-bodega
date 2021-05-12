class AccountsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "accounts_channel:#{current_tenant.id}"
  end

  def unsubscribed
    stop_all_streams
  end
end