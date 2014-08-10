//
//  DiceGameView.m
//  GodThrowDice
//
//  Created by asuka on 14-8-1.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "DiceGameView.h"
#import "RandomOptionItem.h"

@interface DiceGameView()

// 子View, UILabel
@property (strong,nonatomic) UILabel *subLabel;

// 是否正在滚动. 当正在滚动时, 不再接受新的滚动
@property (nonatomic) BOOL isRolling;

@end

@implementation DiceGameView

#pragma mark - 属性

#define ROLLING_TIMES 25
// 滚动间隔时间
#define ROLLING_INTERVAL 0.08

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
    [self setLableText];
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
        [self addSubLabel];
    }
    return self;
}

/**
 *  初始化设置
 */
- (void)setup
{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = [self getFittingSize] / 10;
    self.layer.borderWidth = [self getFittingSize] / 40;
    // self.layer.borderColor = [UIColor redColor].CGColor;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

/**
 *  添加Label子View
 */
- (void)addSubLabel
{
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.subLabel = [[UILabel alloc] initWithFrame:rect];
    self.subLabel.textAlignment = NSTextAlignmentCenter;
    self.subLabel.font = [UIFont systemFontOfSize:[self getFittingSize]];
    self.subLabel.adjustsFontSizeToFitWidth = YES;
//    self.subLabel.layer.borderColor = (__bridge CGColorRef)([UIColor redColor]);
//    self.subLabel.layer.borderWidth = 6;
//    self.subLabel.adjustsLetterSpacingToFitWidth = YES;
    
    [self addSubview:self.subLabel];
}


/**
 *  设置文字
 */
- (void)setLableText
{
    [self.subLabel setText:self.showingOptionName];
}


/**
 *  取字体大小等合适尺寸, 取宽和高中较小的一个
 *
 *  @return CGFloat
 */
- (CGFloat)getFittingSize
{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    return width < height ? width : height;
}



#pragma mark - 动画方法

/**
 *  开始动画滚动
 *
 *  @param targetOption 目标选项
 *  @param options      全部选项
 */
- (void)startAnimateRolling:(NSString *)targetOptionName options:(NSMutableArray *)options
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
    
    self.isRolling = true;
    
    __weak DiceGameView *__self = self;
    dispatch_queue_t q = dispatch_queue_create("dice_rolling_anime", NULL);
    dispatch_async(q, ^{
        int index;
        for (int i = 0; i < ROLLING_TIMES; i++) {
            NSString *optionTextToShow;
            if (i == ROLLING_TIMES - 1) {
                optionTextToShow = targetOptionName;
            } else {
                do {
                    index = arc4random() % options.count;
                    RandomOptionItem *item = options[index];
                    optionTextToShow = item.optionName;
                } while ([optionTextToShow isEqualToString:self.showingOptionName]);
                
            }
            NSLog(@"for i = %d, optionTextToShow: %@, target: %@", i, optionTextToShow, targetOptionName);
            dispatch_async( dispatch_get_main_queue(), ^{
                __self.showingOptionName = optionTextToShow;
                if (i == ROLLING_TIMES - 1) {
                    self.isRolling = false;
                }
            });
            [NSThread sleepForTimeInterval:ROLLING_INTERVAL];
        }
    });
    

}


/**
 *  执行动画滚动
 */
- (void)animateRolling:(NSString *)targetOptionN
{

}


@end


















