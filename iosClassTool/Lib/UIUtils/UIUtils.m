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
#import <CoreText/CoreText.h>

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
+ (void)useClass:(id)class_name loadFountion:(NSString *)function_name andParameter:(id)model
{
    SEL class_sel = NSSelectorFromString(function_name);
    IMP class_imp = [class_name methodForSelector:class_sel];
    loadingFounction = (void(*)(id, SEL, id))class_imp;
    loadingFounction(class_name,class_sel,model);
}

#pragma mark - 获取当前时间 -
/**
 *  获取当前时间
 *  @return string
 */
+ (NSString *)getCurrentDateString
{
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *currentDateStr = [dateFormatter stringFromDate:[NSDate date]];
    //alloc后对不使用的对象别忘了release
    //[dateFormatter release];
    return currentDateStr;
}

#pragma mark - 获取距离目标时间 -
/**
 *   获取距离目标时间
 *  @param seconds 目标时间
 *  @return string
 */
+ (NSString*)getDateStringAfterSeconds:(NSTimeInterval)seconds
{
    NSDate *destDate = [NSDate dateWithTimeIntervalSinceNow:seconds];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //用[NSDate date]可以获取系统当前时间
    NSString *dateStr = [dateFormatter stringFromDate:destDate];
    //alloc后对不使用的对象别忘了release
    //[dateFormatter release];
    return dateStr;
}

#pragma mark - 获取Decoument目录 -
/**
 *   获取Decoument目录
 *
 *  @return string
 */
+ (NSString*)getDocumentDirName
{
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

#pragma mark - 渐变消失 -
/**
 *  渐变消失
 *
 *  @param view 目标View
 */
+ (void)hiddeView:(UIView *)view
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [view setAlpha:0.0f];
    [UIView commitAnimations];
}

#pragma mark - 渐变显示 -
/**
 *  渐变显示
 *
 *  @param view 目标View
 */
+ (void)showView:(UIView *)view
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:1.0];
    [view setAlpha:1.0f];
    [UIView commitAnimations];
}

#pragma mark - 从时间戳获取时间 -
/**
 *  从时间戳获取时间
 *
 *  @param string_timeStamp 时间戳
 *
 *  @return 时间
 */
+ (NSString *)getTimeFromTimeStamp:(NSString *)string_timeStamp
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    //设置时区,这个对于时间的处理有时很重要
    //例如你在国内发布信息,用户在国外的另一个时区,你想让用户看到正确的发布时间就得注意时区设置,时间的换算.YYYY-MM-dd HH:mm:ss
    //例如你发布的时间为2010-01-26 17:40:50,那么在英国爱尔兰那边用户看到的时间应该是多少呢?
    //他们与我们有7个小时的时差,所以他们那还没到这个时间呢...那就是把未来的事做了
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    //NSDate* date = [formatter dateFromString:timeStr];
    //------------将字符串按formatter转成nsdate
    //NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    //NSString *nowtimeStr = [formatter stringFromDate:datenow];
    //----------将nsdate按formatter格式转成nsstring
    //时间转时间戳的方法:
    //NSString *timeSp = [NSString stringWithFormat:@"%ld",(long)[datenow timeIntervalSince1970]];
    //NSLog(@"timeSp:%@",timeSp);
    //时间戳转时间的方法
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[string_timeStamp integerValue]];
    NSString *confromTimespStr = [formatter stringFromDate:confromTimesp];
    return confromTimespStr;
}


#pragma mark - 等待弹窗 -
/**
 *  等待弹窗
 *
 *  @param _infoContent     内容
 *  @param time                   等待时间
 */
+ (void)showHUD:(NSString *)_infoContent afterTime:(float)time
{
    [MBHUDView hudWithBody:_infoContent type:MBAlertViewHUDTypeActivityIndicator hidesAfter:time show:YES];
}

#pragma mark - 提示弹窗 -
/**
 *  提示弹窗
 *
 *  @param _infoContent     内容
 *  @param time                   等待时间
 */
+ (void)showAlterView:(NSString *)_infoContent afterTime:(float)time
{
    [MBHUDView hudWithBody:_infoContent type:MBAlertViewHUDTypeDefault hidesAfter:time show:YES];
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

#pragma mark - 移出动画 -
/**
 *  移出动画
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

#pragma mark - 计算字符串高度 -
/**
 *  计算字符串高度
 *
 *  @param string 内容
 *  @param width 固定宽度
 *
 *  @return 高度
 */
+ (int)getAttributedStringHeightWithString:(NSAttributedString *)string  WidthValue:(int) width{
    int total_height = 0;
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)string);    //string 为要计算高度的NSAttributedString
    CGRect drawingRect = CGRectMake(0, 0, width, 1000);  //这里的高要设置足够大
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, drawingRect);
    CTFrameRef textFrame = CTFramesetterCreateFrame(framesetter,CFRangeMake(0,0), path, NULL);
    CGPathRelease(path);
    CFRelease(framesetter);
    NSArray *linesArray = (NSArray *) CTFrameGetLines(textFrame);
    CGPoint origins[[linesArray count]];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    int line_y = (int) origins[[linesArray count] -1].y;  //最后一行line的原点y坐标
    CGFloat ascent;
    CGFloat descent;
    CGFloat leading;
    CTLineRef line = (__bridge CTLineRef) [linesArray objectAtIndex:[linesArray count]-1];
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    total_height = 1000 - line_y + (int) descent +1;    //+1为了纠正descent转换成int小数点后舍去的值
    CFRelease(textFrame);
    
    total_height = total_height + 10;
    
    return total_height;
}

@end
