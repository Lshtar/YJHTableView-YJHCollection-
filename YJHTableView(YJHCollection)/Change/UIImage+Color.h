//
//  UIImage+Color.h
//  Practise2018.6.13
//
//  Created by D on 2018/7/5.
//  Copyright © 2018年 D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Color)

// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
