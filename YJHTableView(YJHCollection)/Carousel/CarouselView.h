//
//  CarouselView.h
//  Practise2018.6.13
//
//  Created by D on 2018/7/5.
//  Copyright © 2018年 D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarouselCollectionCell.h"

@class CarouselView;

@protocol carouselViewDelegate <NSObject>

- (void)carouselView:(CarouselView*)carouselView didShowItemAtIndex:(NSInteger)itemIndex;

@end

@interface CarouselView : UIView

//图片urlString或者imagename
@property (nonatomic, strong) NSArray<NSString*> *dataSource;
@property (nonatomic, copy) NSString *imageHolderName;
@property (nonatomic, weak) id<carouselViewDelegate> delegate;

@end
