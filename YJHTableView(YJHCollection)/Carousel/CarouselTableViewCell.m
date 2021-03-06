//
//  CarouselTableViewCell.m
//  Practise2018.6.13
//
//  Created by D on 2018/7/9.
//  Copyright © 2018年 D. All rights reserved.
//

#import "CarouselTableViewCell.h"

@interface CarouselTableViewCell ()

@property (nonatomic, weak) UIImageView* imageV;

@end

@implementation CarouselTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.transform = CGAffineTransformMakeRotation(M_PI/2);
        [self createView];
    }
    return self;
}

- (void)createView
{
    UIImageView *imageV = [[UIImageView alloc]init];
    self.imageV = imageV;
    [self addSubview:imageV];
}

- (void)layoutSubviews
{
    [self.imageV setFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}

- (void)fillCarouselCellImage:(UIImage *)image
{
    self.imageV.image = image;
}

- (void)clearCarouselCell
{
    self.imageV.image = [UIImage imageNamed:@""];
}

@end
