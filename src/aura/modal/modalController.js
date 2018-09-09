({
   handleOpenModal: function(component, event, helper) {
      // to display modal, sets the "isOpen" attribute to "true"
      component.set("v.isOpen", $A.util.getBooleanValue(event.getParam("open")));
   },
 
   closeModal: function(component, event, helper) {
      // to close modal, sets the "isOpen" attribute to "false"  
      component.set("v.isOpen", false);
   },
 
   save: function(component, event, helper) {
      alert('Saving functionality not implemented!');
      component.set("v.isOpen", false);
   },
})