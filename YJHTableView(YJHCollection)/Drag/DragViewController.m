//
//  DragViewController.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/28.
//  Copyright © 2018年 D. All rights reserved.
//

#import "DragViewController.h"
#import "DragCollectionViewCell.h"

@interface DragViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, assign) CGFloat offsetY;
@property (nonatomic, strong) UICollectionView* dragCollectionV;
@property (nonatomic, strong) DragCollectionViewCell* dragCollectionCell;
@property (nonatomic, strong) NSMutableArray* dragArray;

@end

@implementation DragViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"拖动";
    
    [self creatDragCollectionView];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

- (void) creatDragCollectionView
{
    UICollectionViewFlowLayout* dragCollectionFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    dragCollectionFlowLayout.minimumInteritemSpacing = 0;
    dragCollectionFlowLayout.minimumLineSpacing = 0;
    
    self.offsetY = 0;
    
    
    _dragCollectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWidth, SCREENHeight) collectionViewLayout:dragCollectionFlowLayout];
    _dragCollectionV.pagingEnabled = YES;
    _dragCollectionV.delegate = self;
    _dragCollectionV.dataSource = self;
    _dragCollectionV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_dragCollectionV];
    
    [_dragCollectionV registerClass:[DragCollectionViewCell class] forCellWithReuseIdentifier:@"dragCollectionCellIdentifier"];
    
    _dragArray = [NSMutableArray array];
    
    for (NSInteger i = 1; i < 10; i++) {
        NSString *str = [NSString stringWithFormat:@"img%ld.jpg",i];
        [_dragArray addObject:str];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dragArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    _dragCollectionCell = (DragCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"dragCollectionCellIdentifier" forIndexPath:indexPath];
    if (_dragCollectionCell == nil) {
        
        _dragCollectionCell.dragImage = [UIImage imageNamed:[_dragArray objectAtIndex:indexPath.item]];
        _dragCollectionCell.backgroundColor = [UIColor blueColor];
    }
    return _dragCollectionCell;
}

#pragma  mark  - UICollectionViewDelegate

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y < 0) {
        return;
    }
    
    //
    NSInteger offset = scrollView.contentOffset.y / SCREENHeight;
    NSIndexPath* index = [NSIndexPath indexPathForItem:offset inSection:0];
    UICollectionViewCell* cell = [self.dragCollectionV cellForItemAtIndexPath:index];
    
    //
    NSIndexPath* nextIndex = [NSIndexPath indexPathForItem:offset + 1 inSection:0];
    UICollectionViewCell* nextCell = [self.dragCollectionV cellForItemAtIndexPath:nextIndex];
    
    //
    CGRect rect = nextCell.frame;
    rect.origin.y = self.dragCollectionV.contentOffset.y;
    nextCell.frame = rect;
    
    [self.dragCollectionV insertSubview:nextCell belowSubview:cell];
    
    //
    if (scrollView.contentOffset.y < self.offsetY) {
        CGFloat progress = (self.offsetY - scrollView.contentOffset.y) / SCREENHeight;
        cell.alpha = progress;
        
        self.dragCollectionCell = nil;
        self.dragCollectionCell = cell;
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self adjustCurrentCell:scrollView];
}

- (void) adjustCurrentCell:(UIScrollView*) scrollView
{
    NSInteger offset = scrollView.contentOffset.y / SCREENHeight;
    NSIndexPath* index = [NSIndexPath indexPathForItem:offset inSection:0];
    
    UICollectionViewCell* cell = [self.dragCollectionV cellForItemAtIndexPath:index];
    
    CGRect rect = cell.frame;
    rect.origin.y = self.dragCollectionV.contentOffset.y;
    cell.frame = rect;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
