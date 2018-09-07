/**
 *
 * Copyright (c) 2018 Salesforce.com
 * @author pfernandez@altimetrik.com
 * @ownership Altimetrik
 */

@isTest
private class TestRoleUtils {

    @isTest static void test_getRoleSubordinateUsers() {
        Test.startTest();
        RoleUtils.getRoleSubordinateUsers();
        Test.stopTest();
    }

    @isTest static void test_getRoleSubordinateUsersByUserId() {
        Test.startTest();
        RoleUtils.getRoleSubordinateUsersByUserId(UserInfo.getUserId());
        Test.stopTest();
    }

}