//
//  UIImage+Utils.m
//  lvgouProjectIphone
//
//  Created by 张明磊 on 14-3-26.
//  Copyright (c) 2014年 lvgou. All rights reserved.
//

#import "UIImage+Utils.h"

@implementation UIImage (Utils)

#pragma mark - 加载图片,不常驻内存 -
/**
 *  加载图片,不常驻内存
 */
+ (UIImage *)imageFileName:(NSString *)filename
{
    @autoreleasepool
    {
        NSString *imageFile = [NSString stringWithFormat:@"%@/%@", [[NSBundle mainBundle] resourcePath], filename];
        UIImage *image =  [UIImage imageWithContentsOfFile:imageFile];
        return image;
    }
}

@end
