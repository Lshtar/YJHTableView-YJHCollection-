//
//  FallsCollectionCell.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/28.
//  Copyright © 2018年 D. All rights reserved.
//

#import "FallsCollectionCell.h"

@implementation FallsCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:arc4random() % 256 / 255.0 green:arc4random() % 256 / 255.0 blue:arc4random() % 256 / 255.0 alpha:1.0];
    }
    return self;
}

@end
