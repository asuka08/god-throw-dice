//
//  RandomGame.m
//  GodThrowDice
//
//  Created by asuka on 14-5-15.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "RandomGame.h"

@interface RandomGame()

/**
 *  当前选中项下标
 */
@property (nonatomic) NSUInteger selectedIndex;

@end

@implementation RandomGame

#pragma mark - 属性

- (NSMutableArray *)optionItems
{
    if (!_optionItems) {
        _optionItems = [[NSMutableArray alloc] init];
    }
    return _optionItems;
}


#pragma mark - 方法

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        self.selectedIndex = 0;
    }
    
    return self;
}



/**
 *  获取当前选中的项
 *
 *  @return 当前选中的项
 */
- (RandomOptionItem *)getSelectedItem
{
    if (self.selectedIndex < self.optionItems.count) {
        return self.optionItems[self.selectedIndex];
    }
    
    return nil;
}

/**
 *  产生随机并获取当前选中的项
 *
 *  @return 产生随机后当前选中的项
 */
- (RandomOptionItem *)generateRandomAndGetSelectedItem
{
    if (self.optionItems == nil || self.optionItems.count == 0) {
        return nil;
    }
    
    NSUInteger totalWeight = 0;
    for (RandomOptionItem *item in self.optionItems) {
        totalWeight += item.weight;
    }
    
    NSUInteger rnd = arc4random() % totalWeight;
    NSUInteger accumulation = 0;
    
    for (NSUInteger i = 0; i < self.optionItems.count; i++) {
        RandomOptionItem *item = self.optionItems[i];
        if (accumulation + item.weight > rnd) {
            self.selectedIndex = i;
            break;
        }
        accumulation += item.weight;
    }
    
    return [self getSelectedItem];
}

@end
