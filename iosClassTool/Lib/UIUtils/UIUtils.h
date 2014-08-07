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

#pragma mark - 非动态绑定,直接地址调用函数 -
/**
 *  非动态绑定
 直接地址调用函数,适用于重复调用的函数可用此for循环
 *  @param class_name    类名
 *  @param function_name 函数名
 *  @param model         函数参数
 */
+ (void)useClass:(id)class_name loadFountion:(NSString *)function_name andParameter:(id)model;

#pragma mark - 获取Decoument目录 -
/**
 *   获取Decoument目录
 *
 *  @return string
 */
+ (NSString*)getDocumentDirName;

#pragma mark - 渐变消失 -
/**
 *  渐变消失
 *
 *  @param view 目标View
 */
+ (void)hiddeView:(UIView *)view;

#pragma mark - 渐变显示 -
/**
 *  渐变显示
 *
 *  @param view 目标View
 */
+ (void)showView:(UIView *)view;

#pragma mark - 从时间戳获取时间 -
/**
 *  从时间戳获取时间
 *  @param string_timeStamp 时间戳
 *  @return 时间
 */
+ (NSString *)getTimeFromTimeStamp:(NSString *)string_timeStamp;

#pragma mark - 获取当前时间 -
/**
 *  获取当前时间
 *  @return string
 */
+ (NSString *)getCurrentDateString;

#pragma mark - 获取距离目标时间 -
/**
 *   获取距离目标时间
 *  @param seconds 目标时间
 *  @return string
 */
+ (NSString*)getDateStringAfterSeconds:(NSTimeInterval)seconds;

#pragma mark - 弹窗等待 -
/**
 *  弹窗等待
 *
 *  @param _infoContent 内容
 *  @param time               持续时间
 */
+ (void)showHUD:(NSString *)_infoContent afterTime:(float)time;

#pragma mark - 弹窗提示 -
/**
 *  弹窗提示
 *
 *  @param _infoContent 提示内容
 *  @param time               持续时间
 */
+ (void)showAlterView:(NSString *)_infoContent afterTime:(float)time;

#pragma mark - 显示等待框 -
/**
 *  显示等待框
 *
 *  @param string_content 内容
 *  @param view_cover 为可点击层,如果为nil,则为全屏遮罩
 */
+ (void)showHUDWithContent:(NSString *)string_content inCoverView:(UIView *)view_cover;

#pragma mark - 消除等待 -
/**
 *  消除等待
 */
+ (void)dismissCurrentHUD;

#pragma mark - 检测网络连接 -
/**
 *  检测网络连接
 *
 *  @return BOOL
 */
+ (BOOL)isConnectNetwork;

#pragma mark - 压缩图片尺寸 -
/**
 *  压缩图片尺寸
 适用于上传图片
 *
 *  @param image   源图片
 *  @param newSize 目标尺寸
 *
 *  @return image
 */
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize;

#pragma mark - 压缩图片大小 -
/**
 *  压缩图片大小
 适用于服务器上传图片
 *
 *  @param tempImage 源图片
 *  @param imageName 保存位置,为空则不保存
 *
 *  @return Data
 */
+ (NSData *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName;

#pragma mark - 进入动画 -
/**
 *  进入动画
 *  进入前设置好view位置
 *  @param view 操作view
 */
+ (void)addViewWithAnimation:(UIView *)view;

#pragma mark - 移出动画 -
/**
 *  移出动画
 *
 *  @param view 源view
 */
+ (void)removedViewWithAnimation:(UIView *)view;

#pragma mark - 按类型提示 -
/**
 *  按类型提示
 *
 *  @param _infoContent 按类型提示
 *  @param view         出现view
 *  @param type         HUB类型
 */
+ (void)view_showProgressHUD:(NSString *) _infoContent inView:(UIView *)view withType:(NSInteger )type;

#pragma mark - 提示文字信息 -
/**
 *  提示文字信息
 *
 *  @param _infoContent 文字源
 *  @param view         出现view
 *  @param time         提示时长
 */
+ (void)view_showProgressHUD:(NSString *) _infoContent inView:(UIView *)view withTime:(float)time;

#pragma mark - HUD消失 -
/**
 *  HUD消失
 *
 *  @param view 所在view
 */
+ (void)view_hideProgressHUDinView:(UIView *)view;

#pragma mark - 计算字符串高度 -
/**
 *  计算字符串高度
 *
 *  @param string 内容
 *  @param width 固定宽度
 *
 *  @return 高度
 */
+ (int)getAttributedStringHeightWithString:(NSAttributedString *)string  WidthValue:(int) width;

#pragma mark - 计算方法花费的时间 -
/**
 *  计算方法花费的时间
 *
 *  @param ^blockvoid 传入方法
 *
 *  @return 时间
 */
CGFloat getTimeBlock (void (^block)(void));

#pragma mark - 多线程执行 -
/**
 *  多线程执行
 *
 *  @param ^blockvoid 传入方法
 */
void runInBackground (void (^block)(void));

#pragma mark - 主线程执行UI -
/**
 *  主线程执行UI
 *
 *  @param ^blockvoid 传入方法
 */
void runInBackgroundMainUI (void (^block)(void));

@end
