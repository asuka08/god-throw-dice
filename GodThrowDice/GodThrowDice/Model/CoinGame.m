//
//  CoinGame.m
//  GodThrowDice
//
//  Created by asuka on 14-5-15.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "CoinGame.h"

@implementation CoinGame

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        // self.optionItems = [[NSMutableArray alloc] init];
        [self.optionItems addObject:[[RandomOptionItem alloc] initWithName:@"obverse" weight:1]];
        [self.optionItems addObject:[[RandomOptionItem alloc] initWithName:@"reverse" weight:1]];
    }
    
    return self;
}

@end
