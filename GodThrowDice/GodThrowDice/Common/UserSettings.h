//
//  UserSettings.h
//  GodThrowDice
//
//  Created by asuka on 14-10-25.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  骰子显示方式枚举
 */
typedef NS_ENUM(NSUInteger, DiceStyle){
    /**
     *  数字方式
     */
    DiceStyleNumber = 0,
    /**
     *  圆点方式
     */
    DiceStyleDots = 1
};


/**
 *  用户配置类
 */
@interface UserSettings : NSObject


/**
 *  骰子数量
 */
@property (nonatomic)NSUInteger dice_quantity;

/**
 *  骰子数量 字符串
 */
@property (nonatomic, readonly)NSString *dice_quantity_string;

/**
 *  骰子面数
 */
@property (nonatomic)NSUInteger dice_sidesNumber;

/**
 *  骰子面数 字符串
 */
@property (nonatomic, readonly)NSString *dice_sidesNumber_string;

/**
 *  骰子显示方式
 */
@property (nonatomic) DiceStyle dice_style;

/**
 *  骰子显示方式 字符串
 */
@property (nonatomic) NSString *dice_style_string;

/**
 *  获取单例
 *
 *  @return 单例实例
 */
+ (UserSettings *)sharedInstance;

@end
