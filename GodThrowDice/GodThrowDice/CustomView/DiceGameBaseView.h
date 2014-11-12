//
//  DiceGameView.h
//  GodThrowDice
//
//  Created by asuka on 14-8-1.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DiceGameBaseView : UIView

/**
 *  当前显示的的骰子点数
 */
@property (strong,nonatomic) NSString *showingOptionName;

- (void)startAnimateRollingWithTarget:(NSString *)targetOptionName options:(NSMutableArray *)options plusTimeSeconds:(double)plusTimeSeconds;

@end
