//
//  YJHPractiseCell.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/13.
//  Copyright © 2018年 D. All rights reserved.
//

#import "YJHPractiseCell.h"

@implementation YJHPractiseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    CGRect rect = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //高亮颜色值
    UIColor *selectedColor = [UIColor cyanColor];
    CGContextSetFillColorWithColor(context, [selectedColor CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    self.selectedBackgroundView = [[UIImageView alloc] initWithImage:image];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    [super setHighlighted:highlighted animated:animated];
    if (highlighted) {
        self.backgroundColor = [UIColor cyanColor];
        self.desLab.textColor = [UIColor blackColor];
    }else {
        self.backgroundColor = [UIColor whiteColor];
        self.desLab.textColor = [UIColor blackColor];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView layoutSubviews];
    self.nameLab.preferredMaxLayoutWidth = CGRectGetWidth(self.nameLab.frame);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self creatUI];
    }
    
    return self;
}

- (void) creatUI
{
    UIImageView* imaView = [[UIImageView alloc] init];
    [self addSubview:imaView];
    [imaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    imaView.backgroundColor = [UIColor orangeColor];
    
//    _nameLab = [[UILabel alloc] init];
//   // [self addSubview:_nameLab];
//    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.mas_left).offset(100);
//        make.top.equalTo(self.mas_top).offset(30);
//        make.size.mas_equalTo(CGSizeMake(200, 40));
//    }];
//    _nameLab.backgroundColor = [UIColor cyanColor];
    
    _desLab = [[UILabel alloc] init];
    [self addSubview:_desLab];
    [_desLab mas_makeConstraints:^(MASConstraintMaker* make){
        make.left.equalTo(self.mas_left).offset(100);
        make.top.equalTo(self.mas_top).offset(30);
        make.size.mas_equalTo(CGSizeMake(200, 40));
    }];
    _desLab.backgroundColor = [UIColor redColor];
    
}

@end
