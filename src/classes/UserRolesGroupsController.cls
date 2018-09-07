/**
 *
 * Copyright (c) 8/23/18 Salesforce.com
 * @author pfernandez@salesforce.com
 * @ownership AppExchange
 */

public class UserRolesGroupsController {


    @AuraEnabled
    public static List<User> getActiveUsers() {
        set<Id> subordinateIds = RoleUtils.getRoleSubordinateUsers();
        return [SELECT u.Name, u.Username, u.Phone, u.Email, u.CompanyName, u.FullPhotoUrl, u.SmallPhotoUrl, u.UserRoleId, u.UserRole.Id, u.UserRole.Name, u.UserRole.ParentRoleId FROM User u
        WHERE Id IN:subordinateIds AND u.isActive = true];
    }

    @AuraEnabled
    public static List<User> getActiveUsersByKeywordSearch(String keyword) {
        set<Id> subordinateIds = RoleUtils.getRoleSubordinateUsers();
        return [SELECT u.Name, u.Username, u.Phone, u.Email, u.CompanyName, u.FullPhotoUrl, u.SmallPhotoUrl, u.UserRoleId, u.UserRole.Id, u.UserRole.Name, u.UserRole.ParentRoleId FROM User u
        WHERE Id IN:subordinateIds AND u.isActive = true AND (u.Name =:keyword OR u.Username =:keyword OR u.UserRole.Name =:keyword)];
    }

    @AuraEnabled
    public static List<User> getSubordinateUsers(String userId) {
        set<Id> subordinateIds = RoleUtils.getRoleSubordinateUsersByUserId(userId);
        return [SELECT u.Name, u.Username, u.Phone, u.Email, u.CompanyName, u.FullPhotoUrl, u.SmallPhotoUrl, u.UserRoleId, u.UserRole.Id, u.UserRole.Name, u.UserRole.ParentRoleId FROM User u
        WHERE Id IN:subordinateIds AND u.isActive = true];
    }

    @AuraEnabled
    public List<User> getMoreUserRoles() {
        set<Id> subordinateIds = RoleUtils.getRoleSubordinateUsers();
        return [SELECT u.Name, u.Username, u.Phone, u.Email, u.CompanyName, u.FullPhotoUrl, u.SmallPhotoUrl, u.UserRoleId, u.UserRole.Id, u.UserRole.Name FROM User u
        WHERE Id IN:subordinateIds AND u.isActive = true];
    }

    @AuraEnabled
    public static String serializeUsersJSON(List<User> users) {
        return JSON.serialize(users);
    }


}