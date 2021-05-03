import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "link", "template", "form" ]

  connect() {
    console.log(this.templateTarget)
    console.log(this.linkTarget)
    console.log(this.formTarget)
  }

  add_association(event){
    event.preventDefault();
    console.log(this.templateTarget)
    console.log(this.linkTarget)
    const content = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, new Date().getTime())
    this.formTarget.insertAdjacentHTML("beforeend", content)
  }

  remove_association(event){
    event.preventDefault();
    let wrapper = event.target.closest(".nested-fields")
    const newRecord = wrapper.dataset.newRecord
    if (newRecord==="true"){
      wrapper.remove()
    }else{
      wrapper.querySelector("input[name*='_destroy']").value = 1
      wrapper.style.display = 'none' 
    }
  }
}