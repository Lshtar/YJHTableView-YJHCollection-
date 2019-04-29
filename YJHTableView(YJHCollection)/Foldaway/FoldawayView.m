//
//  FoldawayView.m
//  Practise2018.6.13
//
//  Created by D on 2018/7/9.
//  Copyright © 2018年 D. All rights reserved.
//

#import "FoldawayView.h"

@implementation FoldawayView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.btn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.btn.frame = self.bounds;
        //[self.btn setBackgroundImage:[UIImage imageNamed:@"btn_on"] forState:UIControlStateNormal];
        [self.btn setBackgroundColor:[UIColor lightGrayColor]];
        [self.btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.btn];
    }
    return self;
}
-(void)btnClick{
    
    self.isAppear = !self.isAppear;
    //3.在合适的时机调用协议方法
    [self.foldawayDelegate changedIsAppear];
    
}

@end
