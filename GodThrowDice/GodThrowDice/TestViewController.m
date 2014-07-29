//
//  TestViewController.m
//  GodThrowDice
//
//  Created by asuka on 14-6-18.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()
@property (weak, nonatomic) IBOutlet UIView *viewContainer;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewCoin;

//@property (nonatomic) CGRect toValueRect;


@end

@implementation TestViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
}

/**
 * 动画开始时
 */
- (void)animationDidStart:(CAAnimation *)theAnimation
{
    NSLog(@"animationDidStart");
}

/**
 * 动画结束时
 */
- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag
{
    NSLog(@"animationDidStop");
//    self.imageViewCoin.layer.bounds = self.toValueRect;
//    self.imageViewCoin.layer.cornerRadius = 0;
//    self.imageViewCoin.layer.borderWidth = 4;
}


- (IBAction)buttonFlipClick:(UIButton *)sender
{
    NSLog(@"buttonFlipClick");
    
    // bounds动画
    CABasicAnimation *animaBounds = [CABasicAnimation animationWithKeyPath:@"bounds"];
    animaBounds.fromValue = [NSValue valueWithCGRect:self.imageViewCoin.layer.bounds];
    CGFloat width = 8.0;
    CGFloat x = (self.viewContainer.layer.bounds.size.width - width) / 2;
    CGRect rect = CGRectMake(x, 0, width, self.viewContainer.layer.bounds.size.height);
    animaBounds.toValue = [NSValue valueWithCGRect:rect];
//    self.toValueRect = rect;
    
    // cornerRadius动画
    CABasicAnimation *animaCornerRadius = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    animaCornerRadius.fromValue = [NSNumber numberWithFloat:80];
    animaCornerRadius.toValue = [NSNumber numberWithFloat:0];
    
    // borderWidth动画
    CABasicAnimation *animaBorderWidth = [CABasicAnimation animationWithKeyPath:@"borderWidth"];
    animaBorderWidth.fromValue = [NSNumber numberWithFloat:0];
    animaBorderWidth.toValue = [NSNumber numberWithFloat:4];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 2;
    group.repeatCount = 1;
    // group.fillMode = kCAFillModeForwards;
    // group.removedOnCompletion = NO;
    // group.delegate = self;
    group.animations = [NSArray arrayWithObjects: animaBounds, animaCornerRadius, animaBorderWidth, nil];
    
    [self.imageViewCoin.layer addAnimation:group forKey:@"coinSpin"];
    
    self.imageViewCoin.layer.bounds = rect;
    self.imageViewCoin.layer.cornerRadius = 0;
    self.imageViewCoin.layer.borderWidth = 4;
    
}

@end











