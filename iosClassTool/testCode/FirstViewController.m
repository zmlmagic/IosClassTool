//
//  FirstViewController.m
//  iosClassTool
//
//  Created by 张明磊 on 14-4-3.
//  Copyright (c) 2014年 张明磊. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"

@implementation FirstViewController

- (void)viewDidLoad
{
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.backgroundColor = [UIColor redColor];
    
    UIButton *button_push = [UIButton buttonWithType:UIButtonTypeCustom];
    button_push.frame = CGRectMake(100, 100, 100, 30);
    button_push.backgroundColor = [UIColor clearColor];
    [button_push setTitle:@"push" forState:UIControlStateNormal];
    [button_push setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button_push addTarget:self action:@selector(didClickButton_push:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button_push];
    button_push.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
    button_push.titleLabel.textAlignment = NSTextAlignmentCenter;
    button_push.titleLabel.textColor = [UIColor whiteColor];
    button_push.titleLabel.shadowColor = [UIColor darkGrayColor];
    button_push.titleLabel.shadowOffset = CGSizeMake(2, 2);
    button_push.layer.cornerRadius = 3.0;
}

- (void)didClickButton_push:(UIButton *)button_push
{
    SecondViewController *viewController = [[SecondViewController alloc] init];
    [self pushViewController:viewController];
}

@end
