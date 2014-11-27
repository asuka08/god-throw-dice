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


#pragma mark - 国际化

#define I18N_USER_SETTINGS_DICE_STYLE_NUMBER NSLocalizedString(@"I18N_USER_SETTINGS_DICE_STYLE_NUMBER", @"Number")
#define I18N_USER_SETTINGS_DICE_STYLE_DOTS NSLocalizedString(@"I18N_USER_SETTINGS_DICE_STYLE_DOTS", @"Dots")


#pragma mark - 属性

#define __UD [NSUserDefaults standardUserDefaults]

#pragma mark - 骰子数量

- (NSUInteger)dice_quantity
{
    NSInteger quantity = [__UD integerForKey:@"dice_quantity"];
    // 默认1个骰子
    if (quantity == 0) {
        quantity = 1;
    }
    return quantity;
}

- (void)setDice_quantity:(NSUInteger)dice_quantity
{
    [__UD setInteger:dice_quantity forKey:@"dice_quantity"];
    [__UD synchronize];
}

- (NSString *)dice_quantity_string
{
    return [NSString stringWithFormat:@"%lu", (unsigned long)self.dice_quantity];
}

#pragma mark - 骰子最大点数

- (NSUInteger)dice_sidesNumber
{
    NSInteger maxNumber = [__UD integerForKey:@"dice_sidesNumber"];
    // 默认最大点数6
    if (maxNumber == 0) {
        maxNumber = 6;
    }
    return maxNumber;
}

- (void)setDice_sidesNumber:(NSUInteger)sidesNumber
{
    [__UD setInteger:sidesNumber forKey:@"dice_sidesNumber"];
    [__UD synchronize];
}

- (NSString *)dice_sidesNumber_string
{
    return [NSString stringWithFormat:@"%lu", (unsigned long)self.dice_sidesNumber];
}

#pragma mark - 骰子显示方式

- (DiceStyle)dice_style
{
    NSInteger style = [__UD integerForKey:@"dice_style"];
    if (style != DiceStyleNumber && style != DiceStyleDots) {
        style = DiceStyleNumber;
    }
    return style;
}

- (void)setDice_style:(DiceStyle)dice_style
{
    [__UD setInteger:dice_style forKey:@"dice_style"];
    [__UD synchronize];
}

- (NSString *)dice_style_string
{
    NSString *styleStr;
    
    switch (self.dice_style) {
        case DiceStyleNumber:
            styleStr = I18N_USER_SETTINGS_DICE_STYLE_NUMBER;
            break;
            
        case DiceStyleDots:
            styleStr = I18N_USER_SETTINGS_DICE_STYLE_DOTS;
            break;
            
        default:
            styleStr = @"";
            break;
    }
    
    return styleStr;
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


#pragma mark - 方法

- (void)setDiceStyleIndex:(NSInteger)index
{
    switch (index) {
        case 0:
            self.dice_style = DiceStyleNumber;
            break;
            
        case 1:
            self.dice_style = DiceStyleDots;
            break;
            
        default:
            break;
    }
}

@end
