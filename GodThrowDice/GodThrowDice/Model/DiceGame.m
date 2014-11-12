//
//  DiceGame.m
//  GodThrowDice
//
//  Created by asuka on 14-5-15.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "DiceGame.h"

@implementation DiceGame

#define DEFAULT_FACE_COUNT 6

- (instancetype)init
{
    self = [self initWithFaceCount:DEFAULT_FACE_COUNT];
    return self;
}

- (instancetype)initWithFaceCount:(NSUInteger)sidesNumber
{
    self = [super init];
    
    if (sidesNumber < 1) {
        sidesNumber = 1;
    }
    
    if (self) {
        for (uint i = 1; i <= sidesNumber; i++) {
            NSString *name = [NSString stringWithFormat:@"%d", i];
            [self.optionItems addObject:[[RandomOptionItem alloc] initWithName:name weight:1]];
        }
    }
    
    return self;
}

@end
