//
//  CarouselTableView.h
//  Practise2018.6.13
//
//  Created by D on 2018/7/9.
//  Copyright © 2018年 D. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CarouselTableView;

@protocol carouselTableViewDelegate <NSObject>

@required
- (void) carouselTableView:(CarouselTableView*) carouselTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

- (void) showOtherImageIndex:(NSIndexPath*) indexPath;

@end


@interface CarouselTableView : UIView

@property (nonatomic, weak) id <carouselTableViewDelegate> carouselDelegate;

- (id) initWithFrame:(CGRect)frame imageArray:(NSArray*) imageArray;

@end
