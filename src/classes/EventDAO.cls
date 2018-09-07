/**
 *
 * Copyright (c) 2018 Salesforce.com
 * @author pfernandez@altimetrik.com
 * @ownership Altimetrik
 */

public with sharing class EventDAO {


    @AuraEnabled
    public static List<Event> getEvents() {
        return [select AccountId, ActivityDate, ActivityDateTime, CreatedById, CreatedDate, Description, DurationInMinutes, EndDateTime, GroupEventType, Id, IsAllDayEvent, IsArchived, IsChild, IsDeleted, IsGroupEvent, IsPrivate, IsRecurrence, IsReminderSet, LastModifiedById, LastModifiedDate, Location, OwnerId, RecurrenceActivityId, RecurrenceDayOfMonth, RecurrenceDayOfWeekMask, RecurrenceEndDateOnly, RecurrenceInstance, RecurrenceInterval, RecurrenceMonthOfYear, RecurrenceStartDateTime, RecurrenceTimeZoneSidKey, RecurrenceType, ReminderDateTime, ShowAs, StartDateTime, Subject, SystemModstamp, WhatId, WhoId from Event where OwnerId =: UserInfo.getUserId()];
    }

    @AuraEnabled
    public static List<Event> getEventsByUser(String userId) {
        return [select AccountId, ActivityDate, ActivityDateTime, CreatedById, CreatedDate, Description, DurationInMinutes, EndDateTime, GroupEventType, Id, IsAllDayEvent, IsArchived, IsChild, IsDeleted, IsGroupEvent, IsPrivate, IsRecurrence, IsReminderSet, LastModifiedById, LastModifiedDate, Location, OwnerId, RecurrenceActivityId, RecurrenceDayOfMonth, RecurrenceDayOfWeekMask, RecurrenceEndDateOnly, RecurrenceInstance, RecurrenceInterval, RecurrenceMonthOfYear, RecurrenceStartDateTime, RecurrenceTimeZoneSidKey, RecurrenceType, ReminderDateTime, ShowAs, StartDateTime, Subject, SystemModstamp, WhatId, WhoId from Event where OwnerId =: userId];
    }

    /*
        Given a list of events, it returns results as JSON object
     */
    @AuraEnabled
    public static String serializeEvents(List<Event> events){
        return JSON.serialize(events);
    }

}