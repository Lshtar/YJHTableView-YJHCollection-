//
//  ParallaxCollectionCellModel.h
//  Practise2018.6.13
//
//  Created by D on 2018/6/29.
//  Copyright © 2018年 D. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParallaxCollectionCellModel : NSObject

@property (nonatomic, copy) NSString* imageName;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* detail;

/**
 *用来模拟加载过的图片
 */
@property (nonatomic, assign) BOOL isDownload;

@end
