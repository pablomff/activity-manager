({
    navigateToRecord : function (id) {
        var navEvt = $A.get("e.force:navigateToSObject").setParams({"recordId": id, "slideDevName": "detail"});
        navEvt.fire();
    },
    deleteRecord : function (id) {

    }
})