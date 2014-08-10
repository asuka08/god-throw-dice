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

- (instancetype)initWithFaceCount:(uint)faceCount
{
    self = [super init];
    
    if (faceCount < 1) {
        faceCount = 1;
    }
    
    if (self) {
        for (uint i = 1; i <= faceCount; i++) {
            NSString *name = [NSString stringWithFormat:@"%d", i];
            [self.optionItems addObject:[[RandomOptionItem alloc] initWithName:name weight:1]];
        }
    }
    
    return self;
}

@end
