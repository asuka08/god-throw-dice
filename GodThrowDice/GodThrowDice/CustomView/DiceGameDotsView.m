//
//  DiceGameDotsView.m
//  GodThrowDice
//
//  Created by asuka on 14/11/7.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "DiceGameDotsView.h"

@implementation DiceGameDotsView

#define __ADD_RECT [rects addObject:[NSValue valueWithCGRect:rect]];


#pragma mark - 方法


- (void)setup
{
    // 设置边框外观
    self.backgroundColor = [UIColor clearColor];
    self.layer.cornerRadius = [self getFittingSize] / 10;
    self.layer.borderWidth = [self getFittingSize] / 40;
    self.opaque = NO;
    self.contentMode = UIViewContentModeRedraw;
}

- (void)updateDisplay
{
    [self setNeedsDisplay];
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


#pragma mark - 绘图方法

- (void)drawRect:(CGRect)rect
{
    [self drawDots];
}



- (void)drawDots
{
    
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                                           cornerRadius:[self getFittingSize]/10];
    [[UIColor whiteColor] setFill];
    [roundedRect fill];
    
    NSUInteger dotsNumber = [self.showingOptionName intValue];
    
    NSMutableArray *rects = [[NSMutableArray alloc] init];
    CGFloat selfW = self.bounds.size.width;
    CGFloat selfH = self.bounds.size.height;
    CGFloat dotW = selfW / 5;
    CGFloat dotH = selfH / 5;
    
    CGRect rect;
    
    
    switch (dotsNumber) {
        case 1:
            rect = CGRectMake(selfW/2 - dotW/2, selfH/2 - dotH/2, dotW, dotH);
            __ADD_RECT
            break;
            
        case 2:
            rect = CGRectMake(selfW/4*3 - dotW/2, selfH/4 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/4 - dotW/2, selfH/4*3 - dotH/2, dotW, dotH);
            __ADD_RECT
            break;
            
        case 3:
            rect = CGRectMake(selfW/4*3 - dotW/2, selfH/4 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/4*2 - dotW/2, selfH/4*2 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/4 - dotW/2, selfH/4*3 - dotH/2, dotW, dotH);
            __ADD_RECT
            break;
            
        case 4:
            rect = CGRectMake(selfW/4 - dotW/2, selfH/4 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/4*3 - dotW/2, selfH/4 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/4 - dotW/2, selfH/4*3 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/4*3 - dotW/2, selfH/4*3 - dotH/2, dotW, dotH);
            __ADD_RECT
            break;
     
        case 5:
            rect = CGRectMake(selfW/4 - dotW/2, selfH/4 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/4*3 - dotW/2, selfH/4 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/2 - dotW/2, selfH/2 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/4 - dotW/2, selfH/4*3 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/4*3 - dotW/2, selfH/4*3 - dotH/2, dotW, dotH);
            __ADD_RECT
            break;
            
        case 6:
            rect = CGRectMake(selfW/4 - dotW/2, selfH/4 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/4*3 - dotW/2, selfH/4 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/4 - dotW/2, selfH/4*2 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/4*3 - dotW/2, selfH/4*2 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/4 - dotW/2, selfH/4*3 - dotH/2, dotW, dotH);
            __ADD_RECT
            rect = CGRectMake(selfW/4*3 - dotW/2, selfH/4*3 - dotH/2, dotW, dotH);
            __ADD_RECT
            break;
            
        default:
            break;
    }
    

    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    for (NSValue *v in rects) {
        CGContextAddEllipseInRect(ctx, [v CGRectValue]);
        CGContextSetFillColorWithColor(ctx, [UIColor blackColor].CGColor);
        CGContextFillPath(ctx);
    }
}

@end








