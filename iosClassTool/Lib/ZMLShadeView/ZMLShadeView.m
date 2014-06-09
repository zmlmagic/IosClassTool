//
//  ZMLShadeView.m
//  iosClassTool
//
//  Created by 张明磊 on 14-5-16.
//  Copyright (c) 2014年 张明磊. All rights reserved.
//

#import "ZMLShadeView.h"

#pragma mark - 初始化背景 -
/**
 初始化背景
 **/
@interface ZMLShadeView_background : UIView

@property (assign, nonatomic) AlertViewBackgroundStyle backgroundStyletyle;

@end

@implementation ZMLShadeView_background

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    switch (self.backgroundStyletyle)
    {
        case AlertViewBackgroundStyleGradient:
        {
            size_t locationsCount = 2;
            CGFloat locations[2] = {0.0f, 1.0f};
            CGFloat colors[8] = {0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.75f};
            CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
            CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, colors, locations, locationsCount);
            CGColorSpaceRelease(colorSpace);
            
            CGPoint center = CGPointMake(self.bounds.size.width / 2, self.bounds.size.height / 2);
            CGFloat radius = MIN(self.bounds.size.width, self.bounds.size.height) ;
            CGContextDrawRadialGradient (context, gradient, center, 0, center, radius, kCGGradientDrawsAfterEndLocation);
            CGGradientRelease(gradient);
        }break;
        case AlertViewBackgroundStyleSolid:
        {
            [[UIColor colorWithWhite:0 alpha:0.5] set];
            CGContextFillRect(context, self.bounds);
        }break;
    }
}

@end

@interface ZMLShadeView ()

@property (weak, nonatomic) UIView *view_content;
@property (weak, nonatomic) UIView *view_background;

@property (assign, nonatomic) AlertViewTransitionStyle transitionStyle;

@end

@implementation ZMLShadeView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // Initialization code
    }
    return self;
}

/**
 *  初始化方法
 *
 *  @param backViewStyle 背景图样式
 *  @param transStyle    动画切换效果
 *  @param view          弹出层样式
 */
- (void)initWithBackViewStyle:(AlertViewBackgroundStyle)backViewStyle andTransStyle:(AlertViewTransitionStyle)transStyle andShowView:(UIView *)view
{
    _transitionStyle = transStyle;
    _view_content = view;
    ZMLShadeView_background *view_back = [[ZMLShadeView_background alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].currentMode.size.width/2 , [UIScreen mainScreen].currentMode.size.height/2)];
    view_back.backgroundStyletyle = backViewStyle;
    [view_back setBackgroundColor:[UIColor clearColor]];
    [self addSubview:view_back];
    _view_background = view_back;
}

#pragma mark - 弹出视图 -
/**
 弹出视图
 **/
- (void)showAnimated
{
    void (^dismissComplete)(void) = ^{
        
    };
    [self transitionInCompletion:dismissComplete];
    [self showBackgroundAnimated];
}


#pragma mark - 收回视图 -
/**
 收回视图
 **/
- (void)dismissAnimated
{
    void (^dismissComplete)(void) = ^{
        
    };
    [self transitionOutCompletion:dismissComplete];
    [self hideBackgroundAnimated];
}

#pragma mark - 弹出动画 -
/**
 *  弹出动画
 */
- (void)showBackgroundAnimated
{
    _view_background.alpha = 0;
    [UIView animateWithDuration:0.3
                     animations:^{
                         _view_background.alpha = 1;
                     }];
    
}

#pragma mark - 隐藏动画 -
/**
 隐藏动画
 **/
- (void)hideBackgroundAnimated
{
    [UIView animateWithDuration:0.3
                     animations:^{
                         _view_background.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         [_view_background removeFromSuperview];
                         _view_background = nil;
                         [self removeFromSuperview];
                     }];
}

#pragma  mark - in动画 -
/**
 in动画
 **/
- (void)transitionInCompletion:(void(^)(void))completion
{
    switch (self.transitionStyle) {
        case AlertViewTransitionStyleSlideFromBottom:
        {
            CGRect rect = _view_content.frame;
            CGRect originalRect = rect;
            rect.origin.y = self.bounds.size.height;
            _view_content.frame = rect;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 _view_content.frame = originalRect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case AlertViewTransitionStyleSlideFromTop:
        {
            CGRect rect = _view_content.frame;
            CGRect originalRect = rect;
            rect.origin.y = -rect.size.height;
            _view_content.frame = rect;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 _view_content.frame = originalRect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case AlertViewTransitionStyleFade:
        {
            _view_content.alpha = 0;
            [UIView animateWithDuration:0.3
                             animations:^{
                                 _view_content.alpha = 1;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case AlertViewTransitionStyleBounce:
        {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(0.01), @(1.2), @(0.9), @(1)];
            animation.keyTimes = @[@(0), @(0.4), @(0.6), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.5;
            [animation setValue:completion forKey:@"handler"];
            [_view_content.layer addAnimation:animation forKey:@"bouce"];
        }
            break;
        case AlertViewTransitionStyleDropDown:
        {
            CGFloat y = _view_content.center.y;
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
            animation.values = @[@(y - self.bounds.size.height), @(y + 20), @(y - 10), @(y)];
            animation.keyTimes = @[@(0), @(0.5), @(0.75), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.4;
            [animation setValue:completion forKey:@"handler"];
            [_view_content.layer addAnimation:animation forKey:@"dropdown"];
        }
            break;
        default:
            break;
    }
}

#pragma  mark - out动画 -
/**
 out动画
 **/
- (void)transitionOutCompletion:(void(^)(void))completion
{
    switch (self.transitionStyle) {
        case AlertViewTransitionStyleSlideFromBottom:
        {
            CGRect rect = _view_content.frame;
            rect.origin.y = self.bounds.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 _view_content.frame = rect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }break;
        case AlertViewTransitionStyleSlideFromTop:
        {
            CGRect rect = _view_content.frame;
            rect.origin.y = -rect.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 _view_content.frame = rect;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case AlertViewTransitionStyleFade:
        {
            [UIView animateWithDuration:0.25
                             animations:^{
                                 _view_content.alpha = 0;
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }
            break;
        case AlertViewTransitionStyleBounce:
        {
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.values = @[@(1), @(1.2), @(0.01)];
            animation.keyTimes = @[@(0), @(0.4), @(1)];
            animation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];
            animation.duration = 0.35;
            [animation setValue:completion forKey:@"handler"];
            [_view_content.layer addAnimation:animation forKey:@"bounce"];
            
            _view_content.transform = CGAffineTransformMakeScale(0.01, 0.01);
        }
            break;
        case AlertViewTransitionStyleDropDown:
        {
            CGPoint point = _view_content.center;
            point.y += self.bounds.size.height;
            [UIView animateWithDuration:0.3
                                  delay:0
                                options:UIViewAnimationOptionCurveEaseIn
                             animations:^{
                                 _view_content.center = point;
                                 CGFloat angle = ((CGFloat)arc4random_uniform(100) - 50.f) / 100.f;
                                 _view_content.transform = CGAffineTransformMakeRotation(angle);
                             }
                             completion:^(BOOL finished) {
                                 if (completion) {
                                     completion();
                                 }
                             }];
        }break;
        default:
            break;
    }
}

@end
