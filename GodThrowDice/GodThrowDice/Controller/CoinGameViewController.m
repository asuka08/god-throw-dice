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

#pragma mark - 国际化

#define I18N_COIN_GAME_VC_TITLE_TAP_OR_SHAKE NSLocalizedString(@"I18N_COIN_GAME_VC_TITLE_TAP_OR_SHAKE", @"TAP or SHAKE")
#define I18N_COIN_GAME_VC_TITLE_FLIPPING NSLocalizedString(@"I18N_COIN_GAME_VC_TITLE_FLIPPING", @"FLIPPING...")


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
    self.label_title.text = I18N_COIN_GAME_VC_TITLE_TAP_OR_SHAKE;
    
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
//    NSLog(@"---- notification received");
    if ([notification.object isKindOfClass:[NSString class]]) {
        NSString *s = (NSString *)notification.object;
        // self.label_title.text = [s uppercaseString];
        self.label_title.text = [[NSBundle mainBundle] localizedStringForKey:s
                                                                       value:s
                                                                       table:@"RandomGame"];
    }
}


#pragma mark - 手势, 摇一摇

- (IBAction)gameView_tap:(UITapGestureRecognizer *)sender
{
    [self startCoinFlipping];
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    [self startCoinFlipping];
}


- (void)startCoinFlipping
{
    RandomOptionItem *item = [self.game generateRandomAndGetSelectedItem];
    self.label_title.text = I18N_COIN_GAME_VC_TITLE_FLIPPING;
    [self.gameView startAnimateFlip:item.optionName];
    
}




@end
