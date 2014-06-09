//
//  ZMLShadeView.h
//  iosClassTool
//
//  Created by 张明磊 on 14-5-16.
//  Copyright (c) 2014年 张明磊. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  背景样式
 */
typedef NS_ENUM(NSInteger, AlertViewBackgroundStyle)
{
    /**
     *  渐变
     */
    AlertViewBackgroundStyleGradient = 0,
    /**
     *  整体
     */
    AlertViewBackgroundStyleSolid,
};

/**
 *  动画效果
 */
typedef NS_ENUM(NSInteger, AlertViewTransitionStyle)
{
    /**
     *  从底部
     */
    AlertViewTransitionStyleSlideFromBottom = 0,
    /**
     *  从顶部
     */
    AlertViewTransitionStyleSlideFromTop,
    /**
     *  淡入
     */
    AlertViewTransitionStyleFade,
    /**
     *  弹出
     */
    AlertViewTransitionStyleBounce,
    /**
     *  下落
     */
    AlertViewTransitionStyleDropDown
};

@interface ZMLShadeView : UIView

/**
 *  初始化方法
 *
 *  @param backViewStyle 背景图样式
 *  @param transStyle    动画切换效果
 *  @param view          弹出层样式
 */
- (void)initWithBackViewStyle:(AlertViewBackgroundStyle)backViewStyle
                andTransStyle:(AlertViewTransitionStyle)transStyle
                  andShowView:(UIView *)view;

- (void)showAnimated;
- (void)dismissAnimated;

@end
