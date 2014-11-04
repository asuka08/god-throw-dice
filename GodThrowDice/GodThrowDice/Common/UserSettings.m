//
//  UserSettings.m
//  GodThrowDice
//
//  Created by asuka on 14-10-25.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "UserSettings.h"

@interface UserSettings()

@end

@implementation UserSettings

#pragma mark - 属性

#define __ud [NSUserDefaults standardUserDefaults]

// 骰子数量
- (NSUInteger)dice_quantity
{
    NSInteger quantity = [__ud integerForKey:@"dice_quantity"];
    // 默认1个骰子
    if (quantity == 0) {
        quantity = 1;
    }
    return quantity;
}

- (void)setDice_quantity:(NSUInteger)dice_quantity
{
    [__ud setInteger:dice_quantity forKey:@"dice_quantity"];
    [__ud synchronize];
}

- (NSString *)dice_quantity_string
{
    return [NSString stringWithFormat:@"%lu", (unsigned long)self.dice_quantity];
}

// 骰子最大点数
- (NSUInteger)dice_sidesNumber
{
    NSInteger maxNumber = [__ud integerForKey:@"dice_sidesNumber"];
    // 默认最大点数6
    if (maxNumber == 0) {
        maxNumber = 6;
    }
    return maxNumber;
}

- (void)setDice_sidesNumber:(NSUInteger)sidesNumber
{
    [__ud setInteger:sidesNumber forKey:@"dice_sidesNumber"];
    [__ud synchronize];
}

- (NSString *)dice_sidesNumber_string
{
    return [NSString stringWithFormat:@"%lu", (unsigned long)self.dice_sidesNumber];
}

#pragma mark - 单例实现

static UserSettings* instance = nil;

+ (void)initialize
{
    if (self == [UserSettings class]) {
        instance = [[self alloc] init];
    }
}

+ (UserSettings *)sharedInstance
{
    return instance;
}



@end
