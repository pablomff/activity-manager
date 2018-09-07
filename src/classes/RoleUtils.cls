/**
 *
 * Copyright (c) 2018 Salesforce.com
 * @author pfernandez@altimetrik.com
 * @ownership Altimetrik
 */

public with sharing class RoleUtils {
/*
		public static List<User> subordinateUsers {
				 get {
							if (subordinateUsers == null) {
									 Id roleId = UserInfo.getUserRoleId();
									 // get all of the roles underneath the user
									 set<Id> allSubRoleIds = getAllSubRoleIds(new set<ID>{roleId});
									 // get all users in those roles
									 subordinateUsers = [SELECT u.Id, u.Name, u.Email, u.UserRole.Name, u.UserRole.ParentRoleId From User u WHERE UserRoleId IN :allSubRoleIds];
							}
							return subordinateUsers;
				 }
				 set;
		}

		public static map<Id, User> subordinateUsersMap {
				 get {
							if (subordinateUsersMap == null) {
									 subordinateUsersMap = new map<Id, User>();
									 for (User u: subordinateUsers) {
												subordinateUsersMap.put(u.Id, u);
									 }
							}
							return subordinateUsersMap;
				 }
				 set;
		}
		*/
    /*
        It returns all the subordinate user ids in a set
     */
    public static set<ID> getRoleSubordinateUsers() {
        // get current user's role id
        Id roleId = UserInfo.getUserRoleId();
        // get all of the roles underneath the user
        set<Id> allSubRoleIds = getAllSubRoleIds(new set<ID>{roleId});
        // get all of the ids for the users in those roles
        map<Id,User> users = new map<Id, User>([SELECT Id, Name, Email, CompanyName From User WHERE UserRoleId IN :allSubRoleIds]);
        // return the ids as a set so you can do what you want with them
        return users.keySet();
    }

    /*
        Given a user id, it returns all the subordinate users
     */
    public static set<ID> getRoleSubordinateUsersByUserId(Id userId) {
        // get requested user's role
        Id roleId = [SELECT UserRoleId FROM User WHERE Id = :userId].UserRoleId;
        // get all of the roles underneath the user
        set<Id> allSubRoleIds = getAllSubRoleIds(new set<ID>{roleId});
        // get all of the ids for the users in those roles
        map<Id,User> users = new map<Id, User>([SELECT Id, Name, Email, CompanyName From User WHERE UserRoleId IN :allSubRoleIds]);
        // return the ids as a set so you can do what you want with them
        return users.keySet();
    }

    /*
        Given a set of role ids, it returns a set with all the subrole ids
     */
    private static set<ID> getAllSubRoleIds(set<ID> roleIds) {
        set<ID> currentRoleIds = new set<ID>();
        // get all of the roles underneath the passed roles
        for(UserRole userRole :[SELECT Id FROM UserRole WHERE ParentRoleId IN :roleIds AND ParentRoleID != null]){
            currentRoleIds.add(userRole.Id);
        }
        // go fetch some more rolls!
        if(currentRoleIds.size() > 0){
            currentRoleIds.addAll(getAllSubRoleIds(currentRoleIds));
        }
        return currentRoleIds;
    }

}