/**
 *
 * Copyright (c) 2018 Salesforce.com
 * @author pfernandez@altimetrik.com
 * @ownership Altimetrik
 */
public class UserGroupUtils {

    private static final String GROUP_TYPE_REGULAR  = 'Regular';
    private static final String GROUP_TYPE_ROLE     = 'Role';
    private static final String GROUP_TYPE_ROLE_N_SUBS  = 'RoleAndSubordinates';

    /*
        Given a user id, it returns the set of ids of the groups which the user is part of

        In an org we can have 3 types of Group related to User:

            1 - Direct Groups : The group which contains the  User as Group Member
            2 - Indirect Groups : It can be of 2 types...
                2.1 - Groups with Roles : The Group which contain Role of User as the Group Member
                2.2 - Nested Groups : The Group which contain another Group as Group Member of which the User is part of.

     */
    public static set<Id> getGroupsRelatedToUser(Id userId){

        //Declaring a set as we don't want Duplicate Group Ids
        set<Id> results = new set<Id>();

        ///Declaring a Map for Group with Role
        map<Id,Id> grRoleMap = new map<Id,Id>();

        //Populating the Map with RelatedID(i.e.UserRoledId) as Key
        for(Group gr : [SELECT Id, RelatedId, Name FROM Group]) {
            grRoleMap.put(gr.relatedId,gr.id);
        }

        //Groups directly associated to user
        set<Id> groupWithUser = new set<Id>();

        //Populating the Group with User with GroupId we are filtering only  for Group of Type Regular,Role and RoleAndSubordinates
        for(GroupMember  u :[SELECT groupId FROM GroupMember WHERE UserOrGroupId =:userId AND (Group.Type = :GROUP_TYPE_REGULAR OR Group.Type =:GROUP_TYPE_ROLE OR Group.Type=:GROUP_TYPE_ROLE_N_SUBS)]) {
            groupWithUser.add(u.groupId);
        }

        //Groups with Role
        for(User  u :[select UserRoleId from User where id =:userId]) {
            //Checking if the current User Role is part of Map or not
            if(grRoleMap.containsKey(u.UserRoleId)) {
                results.add(grRoleMap.get(u.UserRoleId));
            }
        }

        //Combining both the set
        results.addAll(groupWithUser);

        // traversing the whole list of Groups to check any other nested Group
        Map<Id,Id> grMap = new Map<Id,Id>();
        for(GroupMember gr : [SELECT Id, UserOrGroupId, Groupid FROM GroupMember
                              WHERE (Group.Type = :GROUP_TYPE_REGULAR OR Group.Type =:GROUP_TYPE_ROLE OR Group.Type=:GROUP_TYPE_ROLE_N_SUBS)]){
            grMap.put(gr.UserOrGroupId,gr.Groupid);
        }

        for(Id i :results){
            if(grMap.containsKey(i)){
                results.add(grMap.get(i));
            }
        }

        system.debug('########' + results);

        return results;
    }

}