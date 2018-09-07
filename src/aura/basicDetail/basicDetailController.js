({
    navigateToRecord : function(component, event, helper) {
        var recordId = component.get('v.recordId');
        helper.navigateToRecord(recordId);
    },
    deleteRecord : function(component, event, helper) {
        var recordId = component.get('v.recordId');
        helper.deleteRecord(recordId);
    }

})