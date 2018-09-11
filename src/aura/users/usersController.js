({
    doInit : function(component) {
        // create a one-time use instance of the serverEcho action in the server-side controller
        var action = component.get("c.getActiveUsers");
        // Create a callback that is executed after the server-side action returns
        action.setCallback(this, function(response) {
        var state = response.getState();
            if (state === "SUCCESS") {
                console.log('response returned > ', response.getReturnValue());
                var usersReturned = response.getReturnValue();
                if (usersReturned.length > 0){
                    var usersJSON = response.getReturnValue();
                    console.log('server response > ', usersJSON);
                    component.set("v.showUsers", true);
                    component.set("v.users", usersJSON);
                } else {
                    component.set("v.showUsers", false);
                }
            } else if (state === "INCOMPLETE") {
                // do something
            } else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " +
                        errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });

        $A.enqueueAction(action);
    },
    openModal : function(component) {
		var openModalEvent = $A.get("e.c:openModal");
        openModalEvent.setParams({ "open": true, "type" : "user" }).fire();
	}    
})