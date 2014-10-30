//
//  GodThrowDiceFirstViewController.m
//  GodThrowDice
//
//  Created by asuka on 14-5-14.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "CoinGameViewController.h"
#import "CoinGameView.h"
#import "CoinGame.h"
#import "RandomOptionItem.h"
#import "OptionDict.h"

@interface CoinGameViewController ()

@property (weak, nonatomic) IBOutlet CoinGameView *gameView;
@property (weak, nonatomic) IBOutlet UILabel *label_title;
@property (strong,nonatomic) CoinGame *game;

// @property (nonatomic) float currentDuration;
// @property (nonatomic) float currentRadio;

@end

@implementation CoinGameViewController

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
    // self.label_title.text = [self.gameView.showingOption uppercaseString];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationObserver_flipFinished:)
                                                 name:COIN_GAME_NOTIFICATION_FLIP_FINISHED
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:COIN_GAME_NOTIFICATION_FLIP_FINISHED
                                                  object:nil];
}

- (void)notificationObserver_flipFinished:(NSNotification *)notification
{
    NSLog(@"---- notification received");
    if ([notification.object isKindOfClass:[NSString class]]) {
        NSString *s = (NSString *)notification.object;
        self.label_title.text = [s uppercaseString];
    }
}


#pragma mark - 手势

- (IBAction)gameView_tap:(UITapGestureRecognizer *)sender
{
    
    RandomOptionItem *item = [self.game generateRandomAndGetSelectedItem];
    self.label_title.text = @"FLIPPING...";
    [self.gameView startAnimateFlip:item.optionName];
}




@end
