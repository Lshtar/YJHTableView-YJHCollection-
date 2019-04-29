//
//  FoldawayView.h
//  Practise2018.6.13
//
//  Created by D on 2018/7/9.
//  Copyright © 2018年 D. All rights reserved.
//

#import <UIKit/UIKit.h>

//委托者做三件事：
//1.指定协议
@protocol foldawaynHeaderViewDelegate <NSObject>

- (void) changedIsAppear;

@end

@interface FoldawayView : UIView

@property(nonatomic,strong)UIButton *btn;
//是否展开
@property(nonatomic,assign)BOOL isAppear;
//2.声明代理指针
@property(nonatomic,assign)id<foldawaynHeaderViewDelegate> foldawayDelegate;

@end
