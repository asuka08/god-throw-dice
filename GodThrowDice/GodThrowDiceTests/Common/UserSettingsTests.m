//
//  UserSettingsTests.m
//  GodThrowDice
//
//  Created by asuka on 14-10-25.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "UserSettings.h"

@interface UserSettingsTests : XCTestCase

@end

@implementation UserSettingsTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testSettings
{
    UserSettings *settings = [UserSettings sharedInstance];
    NSLog(@"dice_quantity : %d", settings.dice_quantity);
    settings.dice_quantity = 6;
    NSLog(@"dice_quantity : %d", settings.dice_quantity);
}

@end
