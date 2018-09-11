/**
 *
 * Copyright (c) 8/24/18 Salesforce.com
 * @author pfernandez@salesforce.com
 * @ownership AppExchange
 */

public class TasksController {

    @AuraEnabled
    public static String getTasks(){
        List<Task> tasks = TaskDAO.getTasks();
        return TaskDAO.serializeTasks(tasks);
    }

    @AuraEnabled
    public static String getTasksAssignedToUser(String userId){
        List<Task> tasks = TaskDAO.getTasksByUser(userId);
        return TaskDAO.serializeTasks(tasks);
    }
}