//
//  ZMPNavigationBar.h
//  YXClient
//
//  Created by 张明磊 on 14-6-25.
//  Copyright (c) 2014年 张明磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZMPNavigationBar : UIView

/**
 *  显示在导航条上的title集合
 */
@property (nonatomic, strong) NSArray *titles;

/**
 *  当前页码
 */
@property (nonatomic, assign) NSInteger currentPage;

/**
 *  外部设置滑动页面的距离
 */
@property (nonatomic, assign) CGPoint contentOffset;

/**
 *  设置title集合数据源后，进行reload的方法
 */
- (void)reloadData;

@end
