//
//  DiceGameView.h
//  GodThrowDice
//
//  Created by asuka on 14-8-1.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiceGameView : UIView

@property (strong,nonatomic) NSString *showingOptionName;

- (void)startAnimateRollingWithTarget:(NSString *)targetOptionName options:(NSMutableArray *)options plusTimeSeconds:(double)plusTimeSeconds;

@end
