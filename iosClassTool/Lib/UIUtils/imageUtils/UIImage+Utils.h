//
//  UIImage+Utils.h
//  lvgouProjectIphone
//
//  Created by 张明磊 on 14-3-26.
//  Copyright (c) 2014年 lvgou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Utils)

#pragma mark - 加载图片,不常驻内存 -
/**
 *  加载图片,不常驻内存
 */
+ (UIImage *)imageFileName:(NSString *)filename;

@end
