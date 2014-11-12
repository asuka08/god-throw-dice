//
//  GodThrowDiceSecondViewController.m
//  GodThrowDice
//
//  Created by asuka on 14-5-14.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "DiceGameViewController.h"
#import "DiceGameBaseView.h"
#import "DiceGameNumberView.h"
#import "DiceGameDotsView.h"
#import "DiceGame.h"
#import "RandomOptionItem.h"
#import "UserSettings.h"

struct LayoutIndex {
    int Total;
    int Index;
};
typedef struct LayoutIndex LayoutIndex;

@interface DiceGameViewController ()

@property (strong,nonatomic) DiceGame *game;
@property (weak, nonatomic) IBOutlet UIView *view_dicePanel;
@property (strong,nonatomic) NSMutableArray *diceViewList;
@property (nonatomic) BOOL isSettingsChanged;

@property (nonatomic) NSUInteger diceQuantity;


@end

@implementation DiceGameViewController
{
    NSUInteger loadedDiceQuantity;
    NSUInteger loadedDiceSidesNumber;
    DiceStyle loadedDiceStyle;
}

#pragma mark - 属性

- (DiceGame *)game
{
    if (!_game) {
        _game = [[DiceGame alloc] initWithFaceCount:[UserSettings sharedInstance].dice_sidesNumber];
    }
    return _game;
}

- (NSMutableArray *)diceViewList
{
    if (!_diceViewList) {
        _diceViewList = [[NSMutableArray alloc] init];
    }
    return _diceViewList;
}

- (NSUInteger)diceQuantity
{
    return [UserSettings sharedInstance].dice_quantity;
}

- (BOOL)isSettingsChanged
{
    BOOL changed = NO;
    if ([UserSettings sharedInstance].dice_quantity != loadedDiceQuantity
        || [UserSettings sharedInstance].dice_sidesNumber != loadedDiceSidesNumber
        || [UserSettings sharedInstance].dice_style != loadedDiceStyle)
    {
        changed = YES;
    }
    return changed;
}



#pragma mark - 方法

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initDicePanel];
}

- (void)viewWillAppear:(BOOL)animated
{
    if (self.isSettingsChanged) {
        [self initDicePanel];
    }
}

/**
 *  初始化骰子盘
 */
- (void)initDicePanel
{
    for (UIView *subview in self.view_dicePanel.subviews) {
        [subview removeFromSuperview];
    }
    
    [self resetDiceGame];
    
    for (int i = 0; i < self.diceQuantity; i++) {
        CGRect frame;
        frame.origin = CGPointZero;
        CGFloat width = [self getDiceWidth];
        CGSize size = { width, width };
        frame.size = size;
        frame.origin = [self getPoint:i];
        DiceGameBaseView *view = [self generateDiceGameViewWithFrame:frame];
        view.showingOptionName = [self.game getSelectedItem].optionName;
        [self.view_dicePanel addSubview:view];

    }
    
    self->loadedDiceQuantity = [UserSettings sharedInstance].dice_quantity;
    self->loadedDiceSidesNumber = [UserSettings sharedInstance].dice_sidesNumber;
    self->loadedDiceStyle = [UserSettings sharedInstance].dice_style;
}

/**
 *  重置游戏
 */
- (void)resetDiceGame
{
    self.game = [[DiceGame alloc]initWithFaceCount:[UserSettings sharedInstance].dice_sidesNumber];
}

/**
 *  获取骰子View工厂方法
 *
 *  @return 骰子View
 */
- (DiceGameBaseView *)generateDiceGameViewWithFrame:(CGRect)frame
{
    DiceGameBaseView *view = nil;
    
    if ([UserSettings sharedInstance].dice_style == DiceStyleNumber) {
        view = [[DiceGameNumberView alloc] initWithFrame:frame];
    } else if ([UserSettings sharedInstance].dice_style == DiceStyleDots) {
        view = [[DiceGameDotsView alloc] initWithFrame:frame];
    }
    
    return view;
}

#pragma mark - 骰子宽高坐标

/**
 *  获取骰子宽
 *
 *  @return 骰子宽
 */
- (CGFloat)getDiceWidth
{
    CGFloat weight = self.view_dicePanel.frame.size.width / 2;
    
    if (self.diceQuantity == 2 || self.diceQuantity == 3 || self.diceQuantity == 4) {
        weight = self.view_dicePanel.frame.size.width / 2 / 1.5;
    }
    
    if (self.diceQuantity == 5 || self.diceQuantity == 6) {
        weight = self.view_dicePanel.frame.size.width / 3 / 1.5;
    }
    
    return weight;
}


/**
 *  获取骰子布局横方向顺序
 *
 *  @param index 骰子顺序
 *
 *  @return 横方向顺序
 */
- (LayoutIndex)getLayoutXIndex:(int)index
{
    LayoutIndex li;
    switch (self.diceQuantity) {
        case 1:
            // 1个骰子的情况
            li.Total = 1;
            li.Index = 0;
            break;
            
        case 2:
            // 2个骰子的情况
            li.Total = 2;
            switch (index) {
                case 0:
                    li.Index = 0;
                    break;
                case 1:
                    li.Index = 1;
                    break;

            }
            break;
            
        case 3:
            switch (index) {
                case 0:
                    li.Total = 1;
                    li.Index = 0;
                    break;
                case 1:
                    li.Total = 2;
                    li.Index = 0;
                    break;
                case 2:
                    li.Total = 2;
                    li.Index = 1;
                    break;
               
            }
            break;
            
        case 4:
            li.Total = 2;
            switch (index) {
                case 0:
                case 2:
                    li.Index = 0;
                    break;
                case 1:
                case 3:
                    li.Index = 1;
                    break;
            }
            break;
            
        case 5:
            switch (index) {
                case 0:
                    li.Total = 2;
                    li.Index = 0;
                    break;
                case 1:
                    li.Total = 2;
                    li.Index = 1;
                    break;
                case 2:
                    li.Total = 3;
                    li.Index = 0;
                    break;
                case 3:
                    li.Total = 3;
                    li.Index = 1;
                    break;
                case 4:
                    li.Total = 3;
                    li.Index = 2;
                    break;
            }
            break;
            
        case 6:
            li.Total = 3;
            switch (index) {
                case 0:
                case 3:
                    li.Index = 0;
                    break;
                case 1:
                case 4:
                    li.Index = 1;
                    break;
                case 2:
                case 5:
                    li.Index = 2;
                    break;
            }
            break;

    }
    return li;
}


/**
 *  获取骰子布局竖方向数量
 *
 *  @param index 骰子顺序
 *
 *  @return 竖方向数量
 */
- (LayoutIndex)getLayoutYIndex:(int)index
{
    LayoutIndex li;
    switch (self.diceQuantity) {
        case 1:
            // 1个骰子的情况
            li.Total = 1;
            li.Index = 0;
            break;
            
        case 2:
            // 2个骰子
            li.Total = 1;
            li.Index = 0;
            break;
            
        case 3:
            li.Total = 2;
            switch (index) {
                case 0:
                    li.Index = 0;
                    break;
                case 1:
                case 2:
                    li.Index = 1;
                    break;
            }
            break;
            
        case 4:
            li.Total = 2;
            switch (index) {
                case 0:
                case 1:
                    li.Index = 0;
                    break;
                case 2:
                case 3:
                    li.Index = 1;
                    break;
            }
            break;
            
        case 5:
            li.Total = 2;
            switch (index) {
                case 0:
                case 1:
                    li.Index = 0;
                    break;
                case 2:
                case 3:
                case 4:
                    li.Index = 1;
                    break;
            }
            break;
            
        case 6:
            li.Total = 2;
            switch (index) {
                case 0:
                case 1:
                case 2:
                    li.Index = 0;
                    break;
                case 3:
                case 4:
                case 5:
                    li.Index = 1;
                    break;
            }
            break;

    }
    
    return li;
}


/**
 *  获取骰子坐标
 *
 *  @param index 骰子顺序
 *
 *  @return 骰子坐标
 */
- (CGPoint)getPoint:(int)index
{
    LayoutIndex lix = [self getLayoutXIndex:index];
    LayoutIndex liy = [self getLayoutYIndex:index];
    CGPoint point;
    CGFloat boundX = self.view_dicePanel.frame.size.width / lix.Total;
    CGFloat boundY = self.view_dicePanel.frame.size.height / liy.Total;
    point.x = boundX * lix.Index + (boundX - [self getDiceWidth]) / 2;
    point.y = boundY * liy.Index + (boundY - [self getDiceWidth]) / 2;
    return point;
}



#pragma mark - 手势

- (IBAction)diceGameView_tap:(UITapGestureRecognizer *)sender
{
    uint i = 0;
    for (id view in self.view_dicePanel.subviews) {
        if ([view isKindOfClass:[DiceGameBaseView class]]) {
            RandomOptionItem *option =[self.game generateRandomAndGetSelectedItem];
            DiceGameBaseView *diceView = (DiceGameBaseView *)view;
            double plusTime = 0.5 * i;
            [diceView startAnimateRollingWithTarget:option.optionName options:self.game.optionItems plusTimeSeconds:plusTime];
            i++;
        }
    }
}



@end



















