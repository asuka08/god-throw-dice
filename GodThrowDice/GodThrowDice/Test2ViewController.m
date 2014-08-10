//
//  Test2ViewController.m
//  GodThrowDice
//
//  Created by asuka on 14-7-1.
//  Copyright (c) 2014年 verysb. All rights reserved.
//

#import "Test2ViewController.h"

@interface Test2ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label0;
@end

@implementation Test2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // self.label0.font = [UIFont fontWithName:@"Chalkduster" size:64];
    // self.label0.font = [UIFont systemFontOfSize:128];
    self.label0.adjustsFontSizeToFitWidth = YES;
    self.label0.adjustsLetterSpacingToFitWidth = YES;
}

- (IBAction)buttonRoll_Click:(id)sender
{
    NSLog(@"buttonRoll_Click");
    __weak Test2ViewController *__self = self;
    dispatch_queue_t q = dispatch_queue_create("dice_anima", NULL);
    dispatch_async(q, ^{
        int num;
        for (int i = 0; i < 3; i++) {
            num = arc4random() % 10;
            NSLog(@"for %d", num);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSLog(@"nslog, label0: %@",__self.label0.text);
                __self.label0.text = [NSString stringWithFormat:@"%d", num];
            });
            [NSThread sleepForTimeInterval:1];
        }
        
    });
}






@end
