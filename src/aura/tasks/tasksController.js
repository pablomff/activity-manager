({
    doInit : function(component) {
        // create a one-time use instance of the serverEcho action in the server-side controller
        var action;
        if (component.get("v.showTasksForUser")){
            action = component.get("c.getTasksAssignedToUser");
            action.setParams({ userId : component.get("v.userId") });
        } else {
            action = component.get("c.getTasks");
        }
        // Create a callback that is executed after the server-side action returns
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                // Alert the user with the value returned from the server
                var tasksJSON = JSON.parse(response.getReturnValue());
                console.log('server response > ', tasksJSON);
                console.log('server response length > ', tasksJSON.length);
                component.set("v.showTasks", $A.util.getBooleanValue(tasksJSON.length > 0));
                component.set("v.tasks", tasksJSON);
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
        $A.enqueueAction(action);
    },
    openModal : function(component) {
		var openModalEvent = $A.get("e.c:openModal");
        openModalEvent.setParams({ "open": true, "type" : "task" }).fire();
	}    
})