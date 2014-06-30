//
//  ZMPaggingViewController.h
//  YXClient
//
//  Created by 张明磊 on 14-6-25.
//  Copyright (c) 2014年 张明磊. All rights reserved.
//

#import "ZMViewController.h"

typedef void(^XHDidChangedPageBlock)(NSInteger currentPage, NSString *title);

@interface ZMPaggingViewController : ZMViewController

/**
 *  改变页码的回调
 */
@property (nonatomic, copy) XHDidChangedPageBlock didChangedPageCompleted;

/**
 *  对于iOS的Cocotouch的设计，UITabbarController，最做支持5个控制器，多余的会以more来代替，可以见的5个是比较正常的内存管理方案，所以这里提倡最大5个控制器的使用
 */
@property (nonatomic, strong) NSArray *viewControllers;

/*************************以下初始化方法都不使用的话，那讲初始化一个没有滑动菜单的Viewer控制器*************/
/**
 *  初始化带有左边滑动菜单的Viewer控制器
 *
 *  @param leftViewController 目标左边菜单控制器对象
 *
 *  @return 返回Viewer控制器对象
 */
- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController;

/**
 *  初始化带有右边滑动菜单的Viewer控制器
 *
 *  @param rightViewController 目标右边菜单控制器对象
 *
 *  @return 返回Viewer控制器对象
 */
- (instancetype)initWithRightViewController:(UIViewController *)rightViewController;

/**
 *  初始化带有左右滑动菜单的Viewer控制器
 *
 *  @param leftViewController  目标左边菜单控制器对象
 *  @param rightViewController 目标右边菜单控制器对象
 *
 *  @return 返回Viewer控制对象
 */
- (instancetype)initWithLeftViewController:(UIViewController *)leftViewController rightViewController:(UIViewController *)rightViewController;
/********************************************************************************************/

/**
 *  获取当前页码
 *
 *  @return 返回当前页码
 */
- (NSInteger)getCurrentPageIndex;

/**
 *  设置控制器数据源，进行reload的方法
 */
- (void)reloadData;

@end