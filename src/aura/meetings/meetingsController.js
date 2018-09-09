({
    doInit : function(component) {
        // create a one-time use instance of the serverEcho action
        // in the server-side controller
        var action = component.get("c.getMeetings");

        // Create a callback that is executed after
        // the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // Alert the user with the value returned
                // from the server

                var meetingsJSON = JSON.parse(response.getReturnValue());

                console.log('server response > ', meetingsJSON);
                console.log('server response length > ', meetingsJSON.length);

                component.set("v.showMeetings", $A.util.getBooleanValue(meetingsJSON.length > 0));
                component.set("v.meetings", meetingsJSON);
                // You would typically fire a event here to trigger
                // client-side notification that the server-side
                // action is complete
            }
            else if (state === "INCOMPLETE") {
                // do something
            }
            else if (state === "ERROR") {
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

        // optionally set storable, abortable, background flag here

        // A client-side action could cause multiple events,
        // which could trigger other events and
        // other server-side action calls.
        // $A.enqueueAction adds the server-side action to the queue.
        $A.enqueueAction(action);
    },
    
    openModal : function(component) {
		var openModalEvent = $A.get("e.c:openModal");
		openModalEvent.setParams({ "open": true }).fire();		
	}
})