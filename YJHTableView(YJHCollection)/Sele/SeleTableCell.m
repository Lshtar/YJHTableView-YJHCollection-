//
//  SeleTableCell.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/13.
//  Copyright © 2018年 D. All rights reserved.
//

#import "SeleTableCell.h"

@implementation SeleTableCell

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
        self.selected = UITableViewCellSelectionStyleNone;
        
        [self creatSeleCellUI];
    }
    return self;
}

- (void) creatSeleCellUI
{
    UILabel* seleLab = [[UILabel alloc] init];
    seleLab.backgroundColor = [UIColor lightGrayColor];
    seleLab.text = @"lab";
    [self addSubview:seleLab];
    [seleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.leading.mas_equalTo(40);
    }];
    
    UILabel* seleCenterLab = [[UILabel alloc] init];
    seleCenterLab.backgroundColor = [UIColor purpleColor];
    seleCenterLab.text = @"lab1";
    [self addSubview:seleCenterLab];
    [seleCenterLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.leading.equalTo(seleLab.mas_trailing).offset(40);
        make.width.equalTo(seleLab.mas_width);
        
    }];
    
    UILabel* seleCenterLab1 = [[UILabel alloc] init];
    seleCenterLab1.backgroundColor = [UIColor purpleColor];
    seleCenterLab1.text = @"lab1";
    [self addSubview:seleCenterLab1];
    [seleCenterLab1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.leading.equalTo(seleCenterLab.mas_trailing).offset(40);
        make.width.equalTo(seleCenterLab.mas_width);
        
    }];
    UILabel* seleCenterLab2 = [[UILabel alloc] init];
    seleCenterLab2.backgroundColor = [UIColor purpleColor];
    seleCenterLab2.text = @"lab3";
    [self addSubview:seleCenterLab2];
    [seleCenterLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.leading.equalTo(seleCenterLab1.mas_trailing).offset(40);
        make.width.equalTo(seleCenterLab1.mas_width);
        
    }];
    
    UILabel* seleRightLab = [[UILabel alloc] init];
    seleRightLab.backgroundColor = [UIColor blueColor];
    seleRightLab.text = @"lab2";
    [self addSubview:seleRightLab];
    [seleRightLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.leading.equalTo(seleCenterLab2.mas_trailing).offset(40);
        make.trailing.mas_equalTo(-40);
        make.width.equalTo(seleCenterLab2.mas_width);
    }];
}

@end
