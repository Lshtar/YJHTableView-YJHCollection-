//
//  FoldawayCell.m
//  Practise2018.6.13
//
//  Created by D on 2018/7/9.
//  Copyright © 2018年 D. All rights reserved.
//

#import "FoldawayCell.h"

@implementation FoldawayCell

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
        [self creatFoldawayView];
    }
    return self;
}

- (void) creatFoldawayView
{
    _foldawayImaV = [[UIImageView alloc] initWithFrame:CGRectMake(20, 10, 40, 40)];
    [self addSubview:_foldawayImaV];
    
    _foldawayLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 20, 100, 20)];
    [self addSubview:_foldawayLabel];
}

@end
