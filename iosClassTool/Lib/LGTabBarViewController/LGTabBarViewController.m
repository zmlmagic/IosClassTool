//
//  LGTabBarViewController.m
//  LvgouLawyer
//
//  Created by 张明磊 on 14-6-16.
//  Copyright (c) 2014年 张明磊. All rights reserved.
//

#import "LGTabBarViewController.h"
#import "LGTabBarView.h"

@interface LGTabBarViewController ()<LGTabBarViewDelegate>

@end

@implementation LGTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tabBar.hidden = YES;
    [self UI_bar];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)UI_bar{
    LGTabBarView *tabBar = [[LGTabBarView alloc] init];
    [self.view insertSubview:tabBar atIndex:2];
    [tabBar setDelegate:self];
}

#pragma mark - Bar-delegate -
- (void)delegate_didClickButton_tab:(NSInteger)tag{
        [self setSelectedIndex:tag];
}
@end
