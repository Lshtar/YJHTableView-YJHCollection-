//
//  CarouselCollectionLayout.h
//  Practise2018.6.13
//
//  Created by D on 2018/7/4.
//  Copyright © 2018年 D. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CarouselCollectionLayout : UICollectionViewFlowLayout

@property (nonatomic,copy) void(^didScrollAt)(NSInteger index);

@end
