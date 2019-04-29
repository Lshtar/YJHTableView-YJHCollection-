//
//  VisionCell.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/27.
//  Copyright © 2018年 D. All rights reserved.
//

#import "VisionCell.h"

@implementation VisionCell

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
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _visionImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREENWidth, 300)];
        _visionImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_visionImageView];
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, SCREENWidth, 40)];
        _titleLabel.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:0.50];
        _titleLabel.text = @"这是图片上的文字";
        _titleLabel.textAlignment = 1;
        [self.contentView addSubview:_titleLabel];
    }
    return self;
}

/**
 *返回图片大于imageView的高度
 *
 *@return 图片大于imageView的高度
 */
- (CGFloat)imageOverflowHeight
{
    //减200 是因为cell的高度设为200，所以直接写固定值了
    return _visionImageView.frame.size.height - 200;
}

/**
 *设置 imageView偏移量
 *
 *@ param imageOffset 偏移量
 */
- (void)setImageOffset:(CGPoint)imageOffset
{
    CGRect frame = _visionImageView.frame;
    frame.origin = imageOffset;
    _visionImageView.frame = frame;
}

@end
