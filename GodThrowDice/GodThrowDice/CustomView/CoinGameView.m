//
//  CoinGameView.m
//  GodThrowDice
//
//  Created by asuka on 14-5-16.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "CoinGameView.h"
#import "OptionDict.h"

@interface CoinGameView()

@property (strong,nonatomic) UIImageView *subImageView;
@property (nonatomic) CGFloat showingRadio;

// 是否正在翻转. 如果正在翻转, 不接受新的翻转
@property (nonatomic) BOOL isFlipping;
@property (nonatomic) float currentDuration;
@property (nonatomic) float tempTargetRadio;
@property (nonatomic) NSUInteger flipCount;
@property (nonatomic) NSUInteger flipLeft;

@property (nonatomic) NSString *finalTargetOption;
@property (nonatomic) NSString *tempTargetOption;

@end

@implementation CoinGameView

#pragma mark - 属性


#define COIN_PREFIX @"coin_%@"
//#define OPTION_OBVERSE @"obverse"
//#define OPTION_REVERSE @"reverse"


static const float START_DURATION = 0.1;
static const float DURATION_INCREASE_MUTIPLE = 1.2;
static const float MAX_DURATION = 0.7;
static const NSUInteger MAX_FLIP_COUNT = 11;
static const float RADIO_NEW_MOON = 0.0;
static const float RADIO_FULL_MOON = 1.0;

@synthesize showingOption = _showingOption;

- (NSString *)showingOption
{
    if (_showingOption) {
        return _showingOption;
    } else {
        return @"";
    }
}

- (void)setShowingOption:(NSString *)showingOption
{
    _showingOption = showingOption;
    [self setImageViewImage];
}

- (void)setShowingRadio:(CGFloat)radio
{
    if (radio > RADIO_FULL_MOON) {
        _showingRadio = RADIO_FULL_MOON;
    } else if (radio < RADIO_NEW_MOON) {
        _showingRadio = RADIO_NEW_MOON;
    } else {
        _showingRadio = radio;
    }
    [self setImageViewImage];
    
}


#pragma mark - 方法

/**
 *  初始化
 *
 *  @param aDecoder aDecoder
 *
 *  @return id
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
        [self addSubImageView];
    }
    return self;
}

/**
 *  初始化设置
 */
- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
    self.showingRadio = RADIO_FULL_MOON;
}

// 添加ImageView子view
- (void)addSubImageView
{
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.subImageView = [[UIImageView alloc] initWithFrame:rect];
    [self addSubview:self.subImageView];
}

// 设置图像
- (void)setImageViewImage
{
    UIImage *coinImage = [UIImage imageNamed:[NSString stringWithFormat:COIN_PREFIX, self.showingOption]];
    if (coinImage) {
        CGFloat width = self.bounds.size.width * self.showingRadio;
        CGFloat x = ( self.bounds.size.width - width ) / 2;
        CGRect rect = CGRectMake( x, 0, width, self.bounds.size.height);
        [self.subImageView setBounds:rect];
        self.subImageView.image = coinImage;
    }
}

// 变换Radio
- (float)exchangeRadio:(float)radio
{
    float result;
    if (radio == RADIO_NEW_MOON) {
        result = RADIO_FULL_MOON;
    } else {
        result = RADIO_NEW_MOON;
    }
    return result;
}

// 变换目标选项 targetOption
- (NSString *)exchangeTargetOption:(NSString *)targetOption
{
    NSString *result;
    if ( [targetOption isEqualToString:OPTION_COIN_OBVERSE]) {
        result = OPTION_COIN_REVERSE;
    } else {
        result = OPTION_COIN_OBVERSE;
    }
    return result;
}



#pragma mark - 动画方法

// 开始翻转动画
- (void)startAnimateFlip:(NSString *)targetOption
{
    NSLog(@"---- start flip");
    if (!self.isFlipping) {
        self.isFlipping = YES;
        self.currentDuration = START_DURATION;
        self.tempTargetRadio = RADIO_NEW_MOON;
        self.flipLeft = MAX_FLIP_COUNT;
        self.flipCount = 0;
        self.finalTargetOption = targetOption;
        [self animateFlip];
    }
}

// 继续翻转动画
- (void)continueAnimateFlip
{
    if (self.currentDuration < MAX_DURATION) {
        self.currentDuration = self.currentDuration * DURATION_INCREASE_MUTIPLE;
    }
    self.tempTargetRadio = [self exchangeRadio:self.tempTargetRadio];
    if (self.tempTargetRadio == RADIO_FULL_MOON) {
        self.tempTargetOption = [self exchangeTargetOption:self.tempTargetOption];
    }
    self.flipLeft--;
    self.flipCount++;
    [self animateFlip];
}

// 执行翻转动画
- (void)animateFlip
{
    NSLog( @"---- drtn: %f, trd: %f, cnt: %lu, left: %lu, op: %@-%@", self.currentDuration, self.tempTargetRadio, (unsigned long)self.flipCount, (unsigned long)self.flipLeft, self.finalTargetOption, self.tempTargetOption );
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:self.currentDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:)];
    self.showingRadio = self.tempTargetRadio;
    self.showingOption = self.tempTargetOption;
    [UIView commitAnimations];
}


// 翻转动画结束回调函数
- (void)animationFinished:(id)sender
{
    
    if (self.flipLeft > 0) {
        [self continueAnimateFlip];
    } else if (![self.tempTargetOption isEqualToString:self.finalTargetOption]) {
        self.flipLeft += 2;
        [self continueAnimateFlip];
    } else {
        NSLog(@"---- end flip");
        self.isFlipping = NO;
        NSNotification *notification = [NSNotification notificationWithName:COIN_GAME_NOTIFICATION_FLIP_FINISHED object:self.finalTargetOption];
        [[NSNotificationCenter defaultCenter]postNotification:notification];
    }
}



@end
