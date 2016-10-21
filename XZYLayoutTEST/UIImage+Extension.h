//
//  UIImage+Extension.h
//  网易新闻
//
//  Created by apple on 14-7-25.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)
/**
 *  返还颜色图片
 *
 *  @param color    颜色
 *  @param itemSize 尺寸
 *
 *  @return 颜色图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)itemSize;
/**
 *  加水印
 *
 *  @param text 文字
 *
 *  @return 水印图片
 */
- (UIImage *)watermarkImage:(NSString *)text;

@end
