//
//  UIUtils.h
//  lvgouProjectIphone
//
//  Created by 张明磊 on 14-3-26.
//  Copyright (c) 2014年 lvgou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIImage+Utils.h"
#import "Zml_Precompile.h"

#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IOS7_STATEBAR ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ?[self setNeedsStatusBarAppearanceUpdate]:[[UIApplication sharedApplication] setStatusBarHidden:NO])
#define IOS7(view) ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ?[view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, view.frame.size.height + 20)]:NO)
#define IOS7_VERSION ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ?YES:NO)
#undef  IOS7_SIZE
#define IOS7_SIZE ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0 ?20:0)

#undef  RGB
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

@interface UIUtils : NSObject

+ (void)useClass:(id)class_name
    loadFountion:(NSString *)function_name
    andParameter:(id)model;
+ (void)showHUDWithContent:(NSString *)string_content inCoverView:(UIView *)view_cover;
+ (void)dismissCurrentHUD;
+ (BOOL)isConnectNetwork;
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (NSData *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;
+ (void)addViewWithAnimation:(UIView *)view;
+ (void)removedViewWithAnimation:(UIView *)view;

+ (void)view_showProgressHUD:(NSString *) _infoContent inView:(UIView *)view withType:(NSInteger )type;
+ (void)view_showProgressHUD:(NSString *) _infoContent inView:(UIView *)view withTime:(float)time;
+ (void)view_hideProgressHUDinView:(UIView *)view;

@end
