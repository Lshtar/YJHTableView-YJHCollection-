//
//  CarouselCollectionCell.m
//  Practise2018.6.13
//
//  Created by D on 2018/7/4.
//  Copyright © 2018年 D. All rights reserved.
//

#import "CarouselCollectionCell.h"

@implementation CarouselCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self configCarouselCell];
    }
    return self;
}

- (void) configCarouselCell
{
    self.carouselImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height)];
    [self.contentView addSubview:self.carouselImageV];
    
}

- (void)setCarouselNameStr:(NSString *)carouselNameStr
{
    _carouselNameStr = carouselNameStr;
    UIImage* carouselImageName = [UIImage imageNamed:_carouselNameStr];
    if (!carouselImageName) {
        if (_carouselNameStr) {
            carouselImageName = [UIImage imageNamed:_carouselNameStr];
        }
    }
    [self.carouselImageV  sd_setImageWithURL:[NSURL URLWithString:carouselNameStr] placeholderImage:carouselImageName];
}

@end
