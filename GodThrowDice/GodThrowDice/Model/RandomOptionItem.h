//
//  RandomOptionItem.h
//  GodThrowDice
//
//  Created by asuka on 14-5-15.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  随机选项
 */
@interface RandomOptionItem : NSObject

/**
 *  选项名称
 */
@property (strong,nonatomic) NSString *optionName;

/**
 *  权重
 */
@property (nonatomic) NSUInteger weight;

- (instancetype)initWithName:(NSString *)name weight:(NSUInteger)weight;

@end
