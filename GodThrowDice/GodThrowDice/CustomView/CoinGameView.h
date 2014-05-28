//
//  CoinGameView.h
//  GodThrowDice
//
//  Created by asuka on 14-5-16.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CoinGameView : UIView

@property (strong,nonatomic) NSString *showingOption;



- (void)startAnimateFlip:(NSString *)targetOption;

@end
