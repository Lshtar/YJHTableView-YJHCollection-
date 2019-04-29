//
//  DragCollectionViewCell.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/28.
//  Copyright © 2018年 D. All rights reserved.
//

#import "DragCollectionViewCell.h"

@interface DragCollectionViewCell ()

@property (nonatomic, strong) UIImageView* imageView;

@end

@implementation DragCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layoutSubviews];
    }
    return self;
}

- (UIImageView*) imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] init];
        _imageView.frame = CGRectMake(0, 0, 200, 300);
    }
    return _imageView;
}

- (void)setDragImage:(UIImage *)dragImage
{
    _dragImage = dragImage;
    self.imageView.image = dragImage;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self addSubview:self.imageView];
    self.imageView.frame = self.bounds;
}

@end
