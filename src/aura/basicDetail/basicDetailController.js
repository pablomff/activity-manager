({
    navigateToRecord : function(component, event, helper) {
        var recordId = component.get('v.recordId');
        helper.navigateToRecord(recordId);
    },
    deleteRecord : function(component, event, helper) {
        var recordId = component.get('v.recordId');
        helper.deleteRecord(recordId);
    },



    openModal : function(component) {
        var openModalEvent = $A.get("e.c:openModal");
        openModalEvent.setParams({ "open": true, "type" : "user", "userId" : component.get('v.recordId')}).fire();
    }

})