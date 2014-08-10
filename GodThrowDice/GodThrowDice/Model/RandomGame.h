//
//  RandomGame.h
//  GodThrowDice
//
//  Created by asuka on 14-5-15.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RandomOptionItem.h"

/**
 *  随机游戏的基类
 */
@interface RandomGame : NSObject

#pragma mark - 属性

/**
 *  可供随机选择的项, Array of RandomOptionItem
 */
@property (strong,nonatomic) NSMutableArray *optionItems;


#pragma mark - 方法

/**
 *  获取当前选中的项
 *
 *  @return 当前选中的项
 */
- (RandomOptionItem *)getSelectedItem;

/**
 *  产生随机并获取当前选中的项
 *
 *  @return 产生随机后当前选中的项
 */
- (RandomOptionItem *)generateRandomAndGetSelectedItem;


@end
