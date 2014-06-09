//
//  UIUtils.m
//  lvgouProjectIphone
//
//  Created by 张明磊 on 14-3-26.
//  Copyright (c) 2014年 lvgou. All rights reserved.
//

#import "UIUtils.h"
#import "MBHUDView.h"
#import "MBProgressHUD.h"

@implementation UIUtils

void(* loadingFounction)(id, SEL ,id);

#pragma mark - 非动态绑定,直接地址调用函数 -
/**
 *  非动态绑定
 直接地址调用函数,适用于重复调用的函数可用此for循环
 *  @param class_name    类名
 *  @param function_name 函数名
 *  @param model         函数参数
 */
+ (void)useClass:(id)class_name
    loadFountion:(NSString *)function_name
    andParameter:(id)model
{
    SEL class_sel = NSSelectorFromString(function_name);
    IMP class_imp = [class_name methodForSelector:class_sel];
    loadingFounction = (void(*)(id, SEL, id))class_imp;
    loadingFounction(class_name,class_sel,model);
}

#pragma mark - 显示等待框 -
/**
 *  显示等待框
 *
 *  @param string_content 内容
 *  @param view_cover 为可点击层,如果为nil,则为全屏遮罩
 */
+ (void)showHUDWithContent:(NSString *)string_content inCoverView:(UIView *)view_cover
{
    if(view_cover)
    {
        [MBHUDView hudWithBody:string_content type:MBAlertViewHUDTypeActivityIndicator hidesAfter:888.0f show:YES inCoverView:view_cover];
    }
    else
    {
        [MBHUDView hudWithBody:string_content type:MBAlertViewHUDTypeActivityIndicator hidesAfter:888.0f show:YES];
    }
}

#pragma mark - 消除等待框 -
/**
 *  消除等待框
 */
+ (void)dismissCurrentHUD
{
    [MBHUDView dismissCurrentHUD];
}

#pragma mark - 检测网络 -
/**
 *  检测网络
 *
 *  @return BOOL
 */
+ (BOOL)isConnectNetwork
{
    BOOL connect_result = YES;
    /*Reachability *connect_net = [Reachability reachabilityWithHostname:@"www.baidu.com"];
    switch ([connect_net currentReachabilityStatus])
    {
        case NotReachable:
        {
            connect_result = NO;
        }break;
        case ReachableViaWWAN:
        {
            connect_result = YES;
        }break;
        case ReachableViaWiFi:
        {
            connect_result = YES;
        }break;}*/
    return connect_result;
}

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
+ (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

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
+ (NSData *)saveImage:(UIImage *)tempImage WithName:(NSString *)imageName
{
    NSData *imageData = UIImageJPEGRepresentation(tempImage,1);
    if(imageData.length/1000 > 2000)
    {
        for(int i = 0; imageData.length < 2000; i++)
        {
            imageData = UIImageJPEGRepresentation(tempImage,1 - 0.1*i);
        }
    }
    
    if(imageName)
    {
        //NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        //NSString *documentsDirectory = [paths objectAtIndex:0];
        //NSString *fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
        //[imageData writeToFile:fullPathToFile atomically:NO];
        //NSLog(@"%d",imageData.length/1000);
    }
    return imageData;
}

#pragma mark - 进入动画 -
/**
 *  进入动画
 *  进入前设置好view位置
 *  @param view 操作view
 */
+ (void)addViewWithAnimation:(UIView *)view
{
    [UIView animateWithDuration:0.2f animations:
     ^{
         [UIView beginAnimations:nil context:nil];
         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
         [UIView setAnimationDuration:0.2f];
         [UIView setAnimationRepeatCount:1];
         [UIView setAnimationBeginsFromCurrentState:YES];
         [view setCenter:CGPointMake(view.center.x - view.frame.size.width, view.center.y)];
         [UIView commitAnimations];
     }completion:^(BOOL finish){if(finish){
         
     }}];
}

#pragma mark - 移除动画 -
/**
 *  移除动画
 *
 *  @param view 源view
 */
+ (void)removedViewWithAnimation:(UIView *)view
{
    [UIView animateWithDuration:0.2f animations:
     ^{
         [UIView beginAnimations:nil context:nil];
         [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
         [UIView setAnimationDuration:0.2f];
         [UIView setAnimationRepeatCount:1];
         [UIView setAnimationBeginsFromCurrentState:YES];
         [view setCenter:CGPointMake(view.center.x + view.frame.size.width, view.center.y)];
         [UIView commitAnimations];
     }completion:^(BOOL finish){
         if(finish)
         {
             double delayInSeconds = 1;
             dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
             dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                 [view removeFromSuperview];
             });
         }
     }];
}

#pragma mark - 按类型提示 -
/**
 *  按类型提示
 *
 *  @param _infoContent 按类型提示
 *  @param view         出现view
 *  @param type         HUB类型
 */
+ (void)view_showProgressHUD:(NSString *)_infoContent inView:(UIView *)view withType:(NSInteger )type
{
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [progressHUD setCenter:CGPointMake(progressHUD.center.x, progressHUD.center.y -20)];
    [progressHUD setAnimationType:MBProgressHUDAnimationZoom];
    switch (type)
    {
        case 0:
        {
            [progressHUD setMode: MBProgressHUDModeIndeterminate];
        }break;
        case 1:
        {
            [progressHUD setMode:MBProgressHUDModeCustomView];
            UIView *view_back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
            [view_back setBackgroundColor:[UIColor clearColor]];
            [progressHUD setCustomView:view_back];
        }break;
        default:
            break;
    }
    
    [progressHUD setLabelText:_infoContent];
    [progressHUD setLabelFont:[UIFont fontWithName:@"Helvetica-Bold" size:20.0]];
    [progressHUD setRemoveFromSuperViewOnHide:YES];
}

#pragma mark - 提示文字信息 -
/**
 *  提示文字信息
 *
 *  @param _infoContent 文字源
 *  @param view         出现view
 *  @param time         提示时长
 */
+ (void)view_showProgressHUD:(NSString *) _infoContent inView:(UIView *)view withTime:(float)time
{
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [progressHUD setCenter:CGPointMake(progressHUD.center.x, progressHUD.center.y -20)];
    [progressHUD setAnimationType:MBProgressHUDAnimationZoom];
    UIView *view_back = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, 1)];
    [view_back setBackgroundColor:[UIColor clearColor]];
    [progressHUD setCustomView:view_back];
    [progressHUD setMode:MBProgressHUDModeCustomView];
    [progressHUD setLabelText:_infoContent];
    [progressHUD setLabelFont:[UIFont fontWithName:@"Helvetica-Bold" size:20.0]];
    [progressHUD setRemoveFromSuperViewOnHide:YES];
    [self performSelector:@selector(view_hideProgressHUDinView:) withObject:view afterDelay:time];
}

#pragma mark - HUD消失 -
/**
 *  HUD消失
 *
 *  @param view 所在view
 */
+ (void)view_hideProgressHUDinView:(UIView *)view
{
    [MBProgressHUD hideHUDForView:view animated:YES];
}

@end
