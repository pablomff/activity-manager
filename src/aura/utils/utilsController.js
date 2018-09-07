({
    navigateToRecord : function(component, event, helper) {
        var recordId = event.getSource().getLocalId();
        helper.navigateToRecord(recordId);
    },
    deleteRecord : function(component, event, helper) {
        var recordId = event.getSource().getLocalId();
        helper.deleteRecord(recordId);
    }

})