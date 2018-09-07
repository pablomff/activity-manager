/**
 *
 * Copyright (c) 2018 Salesforce.com
 * @author pfernandez@altimetrik.com
 * @ownership Altimetrik
 */

public with sharing class TaskDAO {


    /*** Tasks queries ************************************************************/
    @AuraEnabled
    public static List<Task> getTasks() {
        return [select AccountId, ActivityDate, CallDisposition, CallDurationInSeconds, CallObject, CallType, CreatedById, CreatedDate, Description, Id, IsArchived, IsClosed, IsDeleted, IsHighPriority, IsRecurrence, IsReminderSet, LastModifiedById, LastModifiedDate, OwnerId, Priority, RecurrenceActivityId, RecurrenceDayOfMonth, RecurrenceDayOfWeekMask, RecurrenceEndDateOnly, RecurrenceInstance, RecurrenceInterval, RecurrenceMonthOfYear, RecurrenceRegeneratedType, RecurrenceStartDateOnly, RecurrenceTimeZoneSidKey, RecurrenceType, ReminderDateTime, Status, Subject, SystemModstamp, WhatId, WhoId from Task where OwnerId=:UserInfo.getUserId()];
    }

    @AuraEnabled
    public static List<Task> getTasksByUser(String userId) {
        return [select AccountId, ActivityDate, CallDisposition, CallDurationInSeconds, CallObject, CallType, CreatedById, CreatedDate, Description, Id, IsArchived, IsClosed, IsDeleted, IsHighPriority, IsRecurrence, IsReminderSet, LastModifiedById, LastModifiedDate, OwnerId, Priority, RecurrenceActivityId, RecurrenceDayOfMonth, RecurrenceDayOfWeekMask, RecurrenceEndDateOnly, RecurrenceInstance, RecurrenceInterval, RecurrenceMonthOfYear, RecurrenceRegeneratedType, RecurrenceStartDateOnly, RecurrenceTimeZoneSidKey, RecurrenceType, ReminderDateTime, Status, Subject, SystemModstamp, WhatId, WhoId from Task where OwnerId=:userId];
    }

    /*
    Given a list of tasks, it returns results as JSON object
    */
    @AuraEnabled
    public static String serializeTasks(List<Task> tasks){
        return JSON.serialize(tasks);
    }

}