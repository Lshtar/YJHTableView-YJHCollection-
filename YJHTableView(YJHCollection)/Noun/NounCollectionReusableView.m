//
//  NounCollectionReusableView.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/15.
//  Copyright © 2018年 D. All rights reserved.
//

#import "NounCollectionReusableView.h"

@implementation NounCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
        
        _textLabel = [[UILabel alloc] init];
        [self addSubview:_textLabel];
        _textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        [_textLabel.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
        [_textLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
        [_textLabel.widthAnchor constraintEqualToAnchor:self.widthAnchor].active = YES;
        [_textLabel.heightAnchor constraintEqualToAnchor:self.heightAnchor].active = YES;
    }
    return self;
}

@end
