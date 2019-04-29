//
//  CarouselView.m
//  Practise2018.6.13
//
//  Created by D on 2018/7/5.
//  Copyright © 2018年 D. All rights reserved.
//

#import "CarouselView.h"
#import "CarouselCollectionLayout.h"

#define ITEM_COUNT    10 //条目数
#define REPEAT_TIMES  60//重复次数(60倍时，每条数据重复60次)

@interface CarouselView() <UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UICollectionView*collectionView;
@property (nonatomic, strong) CarouselCollectionLayout* carouselLayout;
@property (nonatomic, strong) NSMutableArray *showArray;
@property (nonatomic, assign) NSInteger currentItem;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation CarouselView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame
{
    frame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.width*100/375.0);
    if (self= [super initWithFrame:frame]) {
        self.carouselLayout =[[CarouselCollectionLayout alloc] init];
     
        _collectionView  =[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)) collectionViewLayout:self.carouselLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.alpha = 1;
        _collectionView.clipsToBounds = NO;
        
        [_collectionView registerClass:[CarouselCollectionCell class] forCellWithReuseIdentifier:@"carouselCollectionCell"];

        [self addSubview:_collectionView];

        self.backgroundColor = [UIColor clearColor];
        [self setHidden:YES];
        
        __weak typeof(self) weakSelf = self;
        [self.carouselLayout setDidScrollAt:^(NSInteger index) {
            weakSelf.currentItem = index%ITEM_COUNT;
            if ([weakSelf.delegate respondsToSelector:@selector(carouselView:didShowItemAtIndex:)]) {
                [weakSelf.delegate carouselView:weakSelf didShowItemAtIndex:index%ITEM_COUNT];
            }
        }];
    }
    return self;
}

-(void)setDelegate:(id<carouselViewDelegate>)delegate
{
    _delegate = delegate;
    
}

-(void)setDataSource:(NSArray<NSString *> *)dataSource
{
    _dataSource = dataSource;
    
    for (int i = 0; i<dataSource.count; i++) {
        NSString *str = dataSource[i];
        
        for (int j = 0; j<REPEAT_TIMES; j++) {
            self.showArray[j*ITEM_COUNT+i] = str;
        }
        
    }
    
    [self.collectionView reloadData];
    
    NSInteger centerItem = ITEM_COUNT*REPEAT_TIMES/2+self.dataSource.count/2;
    
    NSIndexPath *index = [NSIndexPath indexPathForItem:centerItem inSection:0];
    [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    
    [self setHidden:NO];
    
}

-(NSMutableArray *)showArray
{
    if (!_showArray) {
        _showArray = [NSMutableArray array];
        for (int i = 0; i<ITEM_COUNT*REPEAT_TIMES; i++) {
            [_showArray addObject:@""];
        }
    }
    return _showArray;
}

#pragma mark - <UICollectionViewDataSource>
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.showArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CarouselCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"carouselCollectionCell" forIndexPath:indexPath];
    cell.carouselName = self.imageHolderName;
    cell.carouselNameStr = self.showArray[indexPath.row];

    return cell;
}
#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath

{
    //取消之前可能未执行的timer
    [self.timer invalidate];
    
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    //选择条目0.5s后动画已经播完，不使用动画以实现无缝回滚到中间对应条目
    NSIndexPath *index = [NSIndexPath indexPathForItem:indexPath.item%ITEM_COUNT+(REPEAT_TIMES*ITEM_COUNT)/2 inSection:0];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(jumpToTargetItem) userInfo:index repeats:NO];
}

-(void)jumpToTargetItem
{
    [self.collectionView scrollToItemAtIndexPath:self.timer.userInfo atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    [self.timer invalidate];
    self.timer = nil;
}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    //滑动结束时调用，不使用动画以实现无缝回滚到中间对应条目
    NSIndexPath *index = [NSIndexPath indexPathForItem:self.currentItem+(REPEAT_TIMES*ITEM_COUNT)/2 inSection:0];
    [self.collectionView scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

@end
