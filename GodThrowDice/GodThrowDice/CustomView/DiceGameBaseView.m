//
//  DiceGameView.m
//  GodThrowDice
//
//  Created by asuka on 14-8-1.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "DiceGameBaseView.h"
#import "RandomOptionItem.h"

@interface DiceGameBaseView()



// 是否正在滚动. 当正在滚动时, 不再接受新的滚动
@property (nonatomic) BOOL isRolling;

@end

@implementation DiceGameBaseView

#pragma mark - 属性

// 滚动次数
#define ROLLING_TIMES 10
// 滚动间隔时间
#define ROLLING_INTERVAL_SECONDS_INIT 0.08
// 滚动间隔时间增加倍数
#define ROLLING_INTERVAL_INCREASE_TIMES 1.1


@synthesize showingOptionName = _showingOptionName;

- (NSString *)showingOptionName
{
    if (_showingOptionName) {
        return _showingOptionName;
    } else {
        return @"";
    }
}

- (void)setShowingOptionName:(NSString *)showingOption
{
    _showingOptionName = showingOption;
    [self updateDisplay];
}


#pragma mark - 方法

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSLog(@"initWithFrame");
        [self setup];
    }
    return self;
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        NSLog(@"initWithCoder");
        [self setup];
    }
    return self;
}


/**
 *  初始化
 */
- (void)setup
{

}



/**
 *  更新显示
 */
- (void)updateDisplay
{
    
}




#pragma mark - 动画方法

/**
 *  开始动画滚动
 *
 *  @param targetOption 目标选项
 *  @param options      全部选项
 *  @param plusTimeMs   额外增加时间秒数
 */
- (void)startAnimateRollingWithTarget:(NSString *)targetOptionName options:(NSMutableArray *)options plusTimeSeconds:(double)plusTimeSeconds
{
    if (self.isRolling) {
        // 如果已经正在滚动中, 则不再接收新的滚动请求
        return;
    }
    
    if (options.count == 0) {
        // 如果全部选项数量是0, 什么也不做
        return;
    }
    if (options.count == 1) {
        // 如果全部选项数量是1, 不需要动画, 直接显示
        self.showingOptionName = targetOptionName;
    }
    
    self.isRolling = YES;
    
    __weak DiceGameBaseView *__self = self;
    dispatch_queue_t q = dispatch_queue_create("dice_rolling_anime", NULL);
    dispatch_async(q, ^{
        int index;
        double rollingInterval = ROLLING_INTERVAL_SECONDS_INIT;              // 初始滚动间隔时间
        uint plusRollingTimes = plusTimeSeconds / rollingInterval;           // 额外增加的滚动次数
        uint totalRollingTimes = ROLLING_TIMES + plusRollingTimes;           // 总滚动次数
        
        // 循环totalRollingTimes次, 变换骰子面
        for (int i = 0; i < totalRollingTimes; i++) {
            NSString *optionTextToShow;
            if (i == totalRollingTimes - 1) {
                optionTextToShow = targetOptionName;
            } else {
                do {
                    index = arc4random() % options.count;
                    RandomOptionItem *item = options[index];
                    optionTextToShow = item.optionName;
                } while ([optionTextToShow isEqualToString:self.showingOptionName]);
            }
//            NSLog(@"for i = %d, optionTextToShow: %@, target: %@", i, optionTextToShow, targetOptionName);
            dispatch_async( dispatch_get_main_queue(), ^{
                __self.showingOptionName = optionTextToShow;
                if (i == totalRollingTimes - 1) {
                    __self.isRolling = NO;
                }
            });

            // 如果当前滚动次数小于额外滚动次数, 间隔时间就不要增加了
            if (i >= plusRollingTimes) {
                rollingInterval *= ROLLING_INTERVAL_INCREASE_TIMES;
            }
            [NSThread sleepForTimeInterval:rollingInterval];
        }
    });
    

}


@end



















