//
//  NounCollectionFlowLayout.h
//  Practise2018.6.13
//
//  Created by D on 2018/6/15.
//  Copyright © 2018年 D. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NounCollectionFlowLayout;
@protocol NounCollectionFlowLayoutDataSource;


@interface NounCollectionFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, weak) id <NounCollectionFlowLayoutDataSource> dataSource;

@property (nonatomic, assign) CGFloat minimumLineSpacing;
@property (nonatomic, assign) CGFloat minimumInteritemSpacing;

@property (nonatomic, assign) IBInspectable BOOL sectionHeadersPinToVisibleBounds;

@end

@protocol NounCollectionFlowLayoutDataSource<NSObject>

@required

- (NSInteger) collectionView:(UICollectionView*) collectionView layout:(NounCollectionFlowLayout*) layout numberOfColumnInSection:(NSInteger) section;

- (CGFloat) collectionView:(UICollectionView*) collectionView layout:(NounCollectionFlowLayout*) layout itemWidth:(CGFloat) width heightForItemAtIndexPath:(NSIndexPath*) indexPath;

@optional

- (CGFloat) collectionView:(UICollectionView*) collectionView  layout:(NounCollectionFlowLayout*) layout minimumLineSpacingForSectionAtIndex:(NSInteger)section;

- (CGFloat) colletionView:(UICollectionView*) collectionView layout:(NounCollectionFlowLayout*) layout minimumInteritemSpacingForSectionAtIndex:(NSInteger) section;

- (UIEdgeInsets) collectionView:(UICollectionView*) collectionView layout:(NounCollectionFlowLayout*) layout insetForSectionAtIndex:(NSInteger)section;

- (CGFloat) collectionView:(UICollectionView*) collectionView layout:(NounCollectionFlowLayout*) layout referenceHeightForHeaderInSection:(NSInteger) section;

- (CGFloat) collectionView:(UICollectionView*) collectionView layout:(NounCollectionFlowLayout*) layout referenceHeightForFooterInSection:(NSInteger) section;

@end
