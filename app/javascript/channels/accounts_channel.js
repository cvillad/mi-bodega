import consumer from "./consumer"
import CableReady from "cable_ready"

consumer.subscriptions.create("AccountsChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
    console.log("Connected")
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log(data)
    if (data.cableReady) CableReady.perform(data.operations)
    // const{ action, item_id } = data
    // item = document.querySelector(`#item-${item_id}`)
    // switch (action) {
    //   case "use":
    //     item.querySelector(".card-title")
    //     break;
    //   case "return":
    //     item.querySelector(".badge").remove()
    //     break; 
    // }
  }
});