/**
 *
 * Copyright (c) 8/24/18 Salesforce.com
 * @author pfernandez@salesforce.com
 * @ownership AppExchange
 */

public with sharing class EventsController {

    @AuraEnabled
    public static String getMeetings(){
        List<Event> events = EventDAO.getEvents();
        return EventDAO.serializeEvents(events);
    }

    @AuraEnabled
    public static String getMeetingsAssignedToUser(String userId){
        List<Event> events = EventDAO.getEventsByUser(userId);
        return EventDAO.serializeEvents(events);
    }

}