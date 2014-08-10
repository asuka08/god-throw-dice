//
//  GodThrowDiceSecondViewController.m
//  GodThrowDice
//
//  Created by asuka on 14-5-14.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "DiceGameViewController.h"
#import "DiceGameView.h"
#import "DiceGame.h"
#import "RandomOptionItem.h"

@interface DiceGameViewController ()

@property (weak, nonatomic) IBOutlet DiceGameView *gameView;
@property (strong,nonatomic) DiceGame *game;

@end

@implementation DiceGameViewController

#pragma mark - 属性

- (DiceGame *)game
{
    if (!_game) {
        _game = [[DiceGame alloc] init];
    }
    return _game;
}


#pragma mark - 方法

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.gameView.showingOptionName = [self.game getSelectedItem].optionName;
}


#pragma mark - 手势

- (IBAction)gameView_tap:(UITapGestureRecognizer *)sender
{
    RandomOptionItem *item = [self.game generateRandomAndGetSelectedItem];
    [self.gameView startAnimateRolling:item.optionName options:self.game.optionItems];
}



@end




















