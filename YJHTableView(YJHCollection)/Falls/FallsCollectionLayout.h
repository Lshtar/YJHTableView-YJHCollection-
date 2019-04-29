//
//  FallsCollectionLayout.h
//  Practise2018.6.13
//
//  Created by D on 2018/6/28.
//  Copyright © 2018年 D. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FallsCollectionLayout;
@protocol FallsCollectionLayoutDelegate <NSObject>

/**
 计算item高度的代理方法，将item的高度与indexPath传给外界
 */

- (CGFloat) fallsCollection:(FallsCollectionLayout*) fallsCollectionLayout itemHeightForWidth:(CGFloat) itemWidth atIndexPath:(NSIndexPath*) indextPath;

@end

//实现了瀑布流功能，但是不能添加头部和底部视图，如项目中有添加头部或底部视图的需求，请慎用！！！
@interface FallsCollectionLayout : UICollectionViewLayout

/**
 总列数，默认是2
 */
@property (nonatomic, assign) NSInteger columnCount;

/**
 列间距，默认是0
 */
@property (nonatomic, assign) float columnSpacing;

/**
 行间距，默认是0
 */
@property (nonatomic, assign) float rowSpacing;

/**
 section与CollectionView的间距，上、左、下、右，默认是(0, 0, 0, 0)
 */
@property (nonatomic, assign) UIEdgeInsets sectionInset;

/**
 同时设置列间距、行间距、sectionInset
 
 @param columnSpacing 列间距
 @param rowSpacing 行间距
 @param sectionInset 设置上、左、下、右的距离
 */

- (void) setColumnSpacing:(float)columnSpacing rowSpacing:(float) rowSpacing sectionInset:(UIEdgeInsets) sectionInset;

#pragma mark ====== 代理方法、block二选其一 ======
/**
 一下代理属性与block属性二选其一，用来设置每一个item的高度
 会将item的高度与indexPath传递给外界
 如果两个都设置，block的优先级高，即代理无效
 */

/**
 代理方法，用来计算item的高度
 */
@property (nonatomic, assign) id<FallsCollectionLayoutDelegate> delegate;

/**
 计算item高度的block，将item的高度与indexPath传递给外界
 */
@property (nonatomic, strong) CGFloat(^itemHeightBlock) (CGFloat itemHeight, NSIndexPath* indexPath);

#pragma mark ====== 构造方法 ======
+ (instancetype) fallsLayoutWithColumnCount:(float) columnCount;
- (instancetype) initWithColumCount:(float) columnCount;

@end
