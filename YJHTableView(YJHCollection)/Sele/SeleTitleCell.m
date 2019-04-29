//
//  SeleTitleCell.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/13.
//  Copyright © 2018年 D. All rights reserved.
//

#import "SeleTitleCell.h"

@implementation SeleTitleCell

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
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self creatSeleTitleCellUI];
    }
    return self;
}

- (void) creatSeleTitleCellUI
{
    UILabel* seleLab = [[UILabel alloc] init];
    seleLab.backgroundColor = [UIColor brownColor];
    seleLab.text = @"title";
    [self addSubview:seleLab];
    [seleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(10);
        make.top.equalTo(self.mas_top).offset(10);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
}

@end
