//
//  UserSettings.h
//  GodThrowDice
//
//  Created by asuka on 14-10-25.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import <Foundation/Foundation.h>



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
@property (nonatomic)NSString *dice_quantity_string;

/**
 *  骰子面数
 */
@property (nonatomic)NSUInteger dice_sidesNumber;

/**
 *  骰子面数 字符串
 */
@property (nonatomic)NSString *dice_sidesNumber_string;

/**
 *  获取单例
 *
 *  @return 单例实例
 */
+ (UserSettings *)sharedInstance;

@end
