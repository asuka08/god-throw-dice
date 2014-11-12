//
//  DiceGameNumberView.m
//  GodThrowDice
//
//  Created by asuka on 14/11/7.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "DiceGameNumberView.h"

@interface DiceGameNumberView ()

// 子View, UILabel
@property (strong,nonatomic) UILabel *subLabel;

@end


@implementation DiceGameNumberView


#pragma mark - 方法


- (void)setup
{
    // 设置边框外观
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = [self getFittingSize] / 10;
    self.layer.borderWidth = [self getFittingSize] / 40;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
    
    // 添加子控件 Label
    CGRect rect = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    self.subLabel = [[UILabel alloc] initWithFrame:rect];
    self.subLabel.textAlignment = NSTextAlignmentCenter;
    self.subLabel.font = [UIFont systemFontOfSize:[self getFittingSize]];
    self.subLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.subLabel];
}

- (void)updateDisplay
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




@end











