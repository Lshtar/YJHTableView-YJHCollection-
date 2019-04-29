//
//  VisionCell.h
//  Practise2018.6.13
//
//  Created by D on 2018/6/27.
//  Copyright © 2018年 D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VisionCell : UITableViewCell

@property (nonatomic, strong) UIImageView* visionImageView;
@property (nonatomic, strong) UILabel* titleLabel;

//获取图片最大偏移量
- (CGFloat) imageOverflowHeight;
//重新设置图片偏移量
- (void) setImageOffset:(CGPoint) imageOffset;

@end
