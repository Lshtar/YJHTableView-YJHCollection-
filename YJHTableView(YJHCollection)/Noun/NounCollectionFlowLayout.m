//
//  NounCollectionFlowLayout.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/15.
//  Copyright © 2018年 D. All rights reserved.
//

#import "NounCollectionFlowLayout.h"

@interface NounCollectionFlowLayout ()

@property (nonatomic, strong) NSMutableArray<NSMutableArray<UICollectionViewLayoutAttributes*>*>* itemLayoutAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes*>* headerLayoutAttributes;
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes*>* footerLayoutAttributes;

@property (nonatomic, strong) NSMutableArray<NSNumber*>* heightOfSections;
@property (nonatomic, assign) CGFloat contenHeight;

@end

@implementation NounCollectionFlowLayout

- (void) prepareLayout
{
    [super prepareLayout];
    
    NSAssert(self.dataSource != nil, @"NounCollectionFlowLayout.dataSource cann't be nil.");
    if (self.collectionView.isDecelerating || self.collectionView.isDragging) {
        return;
    }
    
    _contenHeight = 0.0;
    _itemLayoutAttributes = [NSMutableArray array];
    _headerLayoutAttributes = [NSMutableArray array];
    _footerLayoutAttributes = [NSMutableArray array];
    _heightOfSections = [NSMutableArray array];
    
    UICollectionView* collectionView = self.collectionView;
    NSInteger const numberOfSections = collectionView.numberOfSections;
    UIEdgeInsets const contentInset = collectionView.contentInset;
    CGFloat const contentWidth = collectionView.bounds.size.width - contentInset.left - contentInset.right;
    
    for (NSInteger section = 0; section < numberOfSections; section++) {
        NSInteger const columnOfSection = [self.dataSource collectionView:collectionView layout:self numberOfColumnInSection:section];
        NSAssert(columnOfSection > 0, @"[NounCollectionFlowLayout collectionView:layout:numberOfColumnInSection] musr be greater than 0");
        UIEdgeInsets const contentInsetOfSection = [self contentInsetForSection:section];
        CGFloat const minimumLineSpacing = [self minimumLineSpacingForSection:section];
        CGFloat const minimumInteritemSpacing = [self minimumInteritemSpacingForSection:section];
        CGFloat const contentWidthOfSection = contentWidth - contentInsetOfSection.left - contentInsetOfSection.right;
        CGFloat const itemWidth = (contentWidthOfSection - (columnOfSection - 1)* minimumInteritemSpacing)/ columnOfSection;
        NSInteger const numberOfItems = [collectionView numberOfItemsInSection:section];
        
        CGFloat headerHeight = 0.0;
        if ([self.dataSource respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
            headerHeight = [self.dataSource collectionView:collectionView layout:self referenceHeightForHeaderInSection:section];
            UICollectionViewLayoutAttributes* headerLayoutAttributes = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            headerLayoutAttributes.frame = CGRectMake(0, _contenHeight, contentWidth, headerHeight);
            [_headerLayoutAttributes addObject:headerLayoutAttributes];
        }
        CGFloat offsetOfColumns[columnOfSection];
        for (NSInteger i = 0; i < columnOfSection; i++) {
            offsetOfColumns[i] = headerHeight+ contentInsetOfSection.top;
        }
        
        NSMutableArray* layoutAttributeOfSection = [NSMutableArray arrayWithCapacity:numberOfItems];
        for (NSInteger item = 0; item < numberOfItems; item++) {
            NSInteger currentColumn = 0;
            for (NSInteger i = 1; i < columnOfSection; i++) {
                if (offsetOfColumns[currentColumn] > offsetOfColumns[i]) {
                    currentColumn = i;
                }
            }
            NSIndexPath* indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            CGFloat itemHeight = [self.dataSource collectionView:collectionView layout:self itemWidth:itemWidth heightForItemAtIndexPath:indexPath];
            CGFloat x = contentInsetOfSection.left + itemWidth*currentColumn + minimumInteritemSpacing* currentColumn;
            CGFloat y = offsetOfColumns[currentColumn] + (item>= columnOfSection? minimumLineSpacing:0.0);
            
            UICollectionViewLayoutAttributes* layoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
            layoutAttribute.frame = CGRectMake(x, y+_contenHeight, itemWidth, itemHeight);
            [layoutAttributeOfSection addObject:layoutAttribute];
            
            offsetOfColumns[currentColumn] = (y+itemHeight);
        }
        [_itemLayoutAttributes addObject:layoutAttributeOfSection];
        
        CGFloat maxOffsetValue = offsetOfColumns[0];
        for (int i = 1; i< columnOfSection; i++) {
            if (offsetOfColumns[i] > maxOffsetValue) {
                maxOffsetValue = offsetOfColumns[i];
            }
        }
        maxOffsetValue = contentInsetOfSection.bottom;
        
        CGFloat footerHeader = 0.0;
        if ([self.dataSource respondsToSelector:@selector(collectionView:layout:referenceHeightForFooterInSection:)]) {
            footerHeader = [self.dataSource collectionView:collectionView layout:self referenceHeightForFooterInSection:section];
            UICollectionViewLayoutAttributes* footerLayoutAttribute = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:UICollectionElementKindSectionFooter withIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
            footerLayoutAttribute.frame = CGRectMake(0.0, _contenHeight+ maxOffsetValue, contentWidth, headerHeight);
            [_footerLayoutAttributes addObject:footerLayoutAttribute];
        }
        
        CGFloat currenSectionHeight = maxOffsetValue + footerHeader;
        [_heightOfSections addObject:@(currenSectionHeight)];
        _contenHeight += currenSectionHeight;
    }
}

- (CGSize) collectionViewContentSize
{
    UIEdgeInsets contentInset = self.collectionView.contentInset;
    CGFloat width = CGRectGetWidth(self.collectionView.bounds) - contentInset.left - contentInset.right;
    CGFloat height = MAX(CGRectGetHeight(self.collectionView.bounds), _contenHeight);
    return CGSizeMake(width, height);
}

- (NSArray<UICollectionViewLayoutAttributes*>*)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray<UICollectionViewLayoutAttributes*>* result = [NSMutableArray array];
    [_itemLayoutAttributes enumerateObjectsUsingBlock:^(NSMutableArray<UICollectionViewLayoutAttributes *> * layoutAttributeOfSection, NSUInteger idx, BOOL * _Nonnull stop) {
        [layoutAttributeOfSection enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
            if (CGRectIntersectsRect(rect, attribute.frame)) {
                [result addObject:attribute];
            }
        }];
    }];
    
    [_headerLayoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
        if (attribute.frame.size.height && CGRectIntersectsRect(rect, attribute.frame)) {
            [result addObject:attribute];
        }
    }];
    
    [_footerLayoutAttributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes *attribute, NSUInteger idx, BOOL * _Nonnull stop) {
        if (attribute.frame.size.height && CGRectIntersectsRect(rect, attribute.frame)) {
            [result addObject:attribute];
        }
    }];
    
    if (self.sectionHeadersPinToVisibleBounds) {
        for (UICollectionViewLayoutAttributes* attribute in result) {
            if (![attribute.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) continue; {
                NSInteger section = attribute.indexPath.section;
                UIEdgeInsets contentInsetOfSection = [self contentInsetForSection:section];
                NSIndexPath* firstIndexPath = [NSIndexPath indexPathForItem:0 inSection:section];
                UICollectionViewLayoutAttributes* itemAttribute = [self layoutAttributesForItemAtIndexPath:firstIndexPath];
                CGFloat headerHeight = CGRectGetHeight(attribute.frame);
                CGRect frame = attribute.frame;
                frame.origin.y = MIN(MAX(self.collectionView.contentOffset.y, CGRectGetMinY(itemAttribute.frame)-headerHeight-contentInsetOfSection.top), CGRectGetMinY(itemAttribute.frame)+[_heightOfSections[section] floatValue]);
                attribute.frame = frame;
                attribute.zIndex = (NSIntegerMax/2)+ section;
            }
        }
    }
    return result;
}

- (UICollectionViewLayoutAttributes*) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return _itemLayoutAttributes[indexPath.section][indexPath.item];
}

- (UICollectionViewLayoutAttributes*) layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        for (UICollectionViewLayoutAttributes* attributes in _headerLayoutAttributes) {
            if (attributes.indexPath.section == indexPath.section) {
                return attributes;
            }
        }
    }
    if ([elementKind isEqualToString:UICollectionElementKindSectionFooter]) {
        for (UICollectionViewLayoutAttributes* attributes in _footerLayoutAttributes) {
            if (attributes.indexPath.section == indexPath.section) {
                return attributes;
            }
        }
    }
    return nil;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

#pragma mark Private

- (UIEdgeInsets) contentInsetForSection:(NSInteger) section
{
    UIEdgeInsets edgeInsets = UIEdgeInsetsZero;
    if ([self.dataSource respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
        edgeInsets = [self.dataSource collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
    }
    return edgeInsets;
}

- (CGFloat) minimumLineSpacingForSection:(NSInteger) section
{
    CGFloat minimumLineSpacing = self.minimumLineSpacing;
    if ([self.dataSource respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
        minimumLineSpacing = [self.dataSource collectionView:self.collectionView layout:self minimumLineSpacingForSectionAtIndex:section];
    }
    return minimumLineSpacing;
}

- (CGFloat)minimumInteritemSpacingForSection:(NSInteger)section
{
    CGFloat minimumInteritemSpacing = self.minimumInteritemSpacing;
    if ([self.dataSource respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
        minimumInteritemSpacing = [self.dataSource colletionView:self.collectionView layout:self minimumInteritemSpacingForSectionAtIndex:section];
        
    }
    return minimumInteritemSpacing;
}

@end
