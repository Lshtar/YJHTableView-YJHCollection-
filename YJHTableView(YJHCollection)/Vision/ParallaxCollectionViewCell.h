//
//  ParallaxCollectionViewCell.h
//  Practise2018.6.13
//
//  Created by D on 2018/6/28.
//  Copyright © 2018年 D. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParallaxCollectionCellModel.h"

@interface ParallaxCollectionViewCell : UICollectionViewCell

/**
 *cell相对于window的偏移量x
 */
@property (nonatomic, assign) CGFloat cellOffSetY;

- (void) getValueFromModel:(ParallaxCollectionCellModel*) model;

@end
