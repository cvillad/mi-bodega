// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import "bootstrap"
import "controllers"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

$(document).on("turbolinks:load", function() {
  const handlePlanChange = function(plan_type) {
    if(plan_type == undefined) {
      plan_type = $('#tenant_plan :selected').val();
    }
    if( plan_type === 'moderate' || plan_type === 'unlimited') {
      $('[data-stripe]').show();
    } else {
      $('[data-stripe]').hide();
    }
  }
  
  handlePlanChange($('#tenant_plan :selected').val())
  // Set up plan change event listener #tenant_plan id in the forms for class cc_form
  $("#tenant_plan").on('change', function(event) {
    handlePlanChange($('#tenant_plan :selected').val());
  });
});