//
//  GodThrowDiceFirstViewController.m
//  GodThrowDice
//
//  Created by asuka on 14-5-14.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "GodThrowDiceFirstViewController.h"
#import "CoinGameView.h"
#import "CoinGame.h"
#import "RandomOptionItem.h"

@interface GodThrowDiceFirstViewController ()

@property (weak, nonatomic) IBOutlet CoinGameView *gameView;
@property (strong,nonatomic) CoinGame *game;

@property (nonatomic) float currentDuration;
@property (nonatomic) float currentRadio;

@end

@implementation GodThrowDiceFirstViewController

#pragma mark - 属性



- (CoinGame *)game
{
    if (!_game) {
        _game = [[CoinGame alloc] init];
    }
    return _game;
}

#pragma mark - 方法

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.gameView.showingOption = [self.game getSelectedItem].optionName;
}


#pragma mark - 手势


- (IBAction)gameView_tap:(UITapGestureRecognizer *)sender
{
    
    RandomOptionItem *item = [self.game generateRandomAndGetSelectedItem];
    // self.gameView.optionName = item.optionName;
    [self.gameView startAnimateFlip:item.optionName];
}

#pragma mark - 动画



/*
- (void)startAnimateFlip
{
    
}


- (void)animateFlip
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:@"coinFlip" context:context];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    self.gameView.radio = 0.0;
    [UIView commitAnimations];
}

- (void)animationFinished:(id)sender
{
    NSLog(@"animation finished");
}
 */


@end
