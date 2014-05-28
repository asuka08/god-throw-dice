//
//  RandomOptionItem.m
//  GodThrowDice
//
//  Created by asuka on 14-5-15.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "RandomOptionItem.h"

@implementation RandomOptionItem

- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    
    if (self) {
        self.optionName = name;
        self.weight = 1;
    }
    
    return self;
}


- (instancetype)initWithName:(NSString *)name weight:(NSUInteger)weight
{
    self = [super init];
    
    if (self) {
        self.optionName = name;
        self.weight = weight;
    }
    
    return self;
}

@end
