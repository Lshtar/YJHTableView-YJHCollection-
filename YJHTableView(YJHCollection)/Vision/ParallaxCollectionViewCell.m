//
//  ParallaxCollectionViewCell.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/28.
//  Copyright © 2018年 D. All rights reserved.
//

#import "ParallaxCollectionViewCell.h"

#define kCenterOffSet   30.0f

@interface ParallaxCollectionViewCell ()

@property (nonatomic, strong) UILabel* titleLabel;
@property (nonatomic, strong) UIImageView* mainImageView;
@property (nonatomic, strong) UILabel* detailLabel;
@property (nonatomic, strong) UIView* coverView;

@end

@implementation ParallaxCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //一定要注意,这个属性非常重要,超出父视图的视图不会显示出来.
        self.clipsToBounds = YES;
        
        [self creatCustomousView];
        [self creatLayoutCustomousView];
        
    }
    return self;
}

- (void) creatCustomousView
{
    self.mainImageView = [UIImageView new];
    //设置图片的填充方式为填满,并且设置图片的大小超出cell本身,但是中心点居中.
    self.mainImageView.contentMode  = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.mainImageView];
    
    self.coverView = [UIView new];
    self.coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.2];
    [self.contentView addSubview:self.coverView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont systemFontOfSize:17];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = 1;
    [self.contentView addSubview:self.titleLabel];
    
    self.detailLabel = [UILabel new];
    self.detailLabel.font = [UIFont systemFontOfSize:13];
    self.detailLabel.textColor = [UIColor whiteColor];
    self.detailLabel.textAlignment = 1;
    [self.contentView addSubview:self.detailLabel];
}

- (void) creatLayoutCustomousView
{
    
}

@end
