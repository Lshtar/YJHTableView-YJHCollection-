//
//  NounHeaderFooterViewController.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/19.
//  Copyright © 2018年 D. All rights reserved.
//

#import "NounHeaderFooterViewController.h"
#import "NounCollectionCell.h"
#import "NounCollectionReusableView.h"
#import "NounCollectionFlowLayout.h"

@interface NounHeaderFooterViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSNumber*>*>* datas;
@property (nonatomic, strong) UICollectionView* nounHeaderFooterCollectionView;

@end

@implementation NounHeaderFooterViewController

static NSString* const headerReusIdentifier = @"nounCollectionHeaderIdentifier";
static NSString* const footrReusIdentifier = @"nounCollectionFooterIdentifier";

- (instancetype)init
{
    self = [super init];
    if (self) {
        _datas = [NSMutableArray array];
        for (int i = 0; i< 10; i++) {
            NSMutableArray<NSNumber*>* section = [NSMutableArray array];
            for (int j = 0; j<10; j++) {
                CGFloat height = arc4random_uniform(100)+ 30.0;
                [section addObject:@(height)];
            }
            [_datas addObject:section];
        }
        
        [self.nounHeaderFooterCollectionView registerClass:[NounCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerReusIdentifier];
        [self.nounHeaderFooterCollectionView registerClass:[NounCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footrReusIdentifier];
        
        //头部视图悬停
        NounCollectionFlowLayout* layout = (NounCollectionFlowLayout*) self.nounHeaderFooterCollectionView.collectionViewLayout;
        layout.sectionHeadersPinToVisibleBounds = YES;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"瀑布流Header悬停";
    
    [self creatNounHeaderFooterCollectionView];
    
}

- (void) creatNounHeaderFooterCollectionView
{
    CGRect nounCollectionViewFrame = CGRectMake(0, 64, SCREENWidth, SCREENHeight);
    
    UICollectionViewFlowLayout* nounFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    _nounHeaderFooterCollectionView = [[UICollectionView alloc] initWithFrame:nounCollectionViewFrame collectionViewLayout:nounFlowLayout];
    _nounHeaderFooterCollectionView.backgroundColor = [UIColor whiteColor];
    _nounHeaderFooterCollectionView.delegate = self;
    _nounHeaderFooterCollectionView.dataSource = self;
    _nounHeaderFooterCollectionView.showsVerticalScrollIndicator = NO;
    _nounHeaderFooterCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_nounHeaderFooterCollectionView];
    
    [_nounHeaderFooterCollectionView registerClass:[NounCollectionCell class] forCellWithReuseIdentifier:@"nounHeaderFooterCollectionCellIdentifier"];
    
//    UICollectionViewLayoutAttributes *attributes = [_nounHeaderFooterCollectionView layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]];
//    CGRect rect = attributes.frame;
//    [_nounHeaderFooterCollectionView setContentOffset:CGPointMake(_nounHeaderFooterCollectionView.frame.origin.x, rect.origin.y - 44) animated:YES];
    

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.datas.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.datas objectAtIndex:section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NounCollectionCell* headerFooterCell = (NounCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"nounHeaderFooterCollectionCellIdentifier" forIndexPath:indexPath];
    if (headerFooterCell == nil) {
        headerFooterCell.textLabel.text = [NSString stringWithFormat:@"%@ %ld",indexPath.section, indexPath.item];
    }
    headerFooterCell.backgroundColor = [UIColor purpleColor];
    return headerFooterCell;
}

#pragma mark <UICollectionViewDelegate>

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSString* identifier = (kind == UICollectionElementKindSectionHeader)? headerReusIdentifier:footrReusIdentifier;
    NounCollectionReusableView* nounCollectionReusableView = (NounCollectionReusableView*) [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:identifier forIndexPath:indexPath];
    nounCollectionReusableView.textLabel.text = [NSString stringWithFormat:@"%@",@"%ld",kind,indexPath.section];
    return nounCollectionReusableView;
}

#pragma mark <NounCollectionFlowLayout>

- (NSInteger) collectionView:(UICollectionView*) collectionView layout:(NounCollectionFlowLayout*) layout numberOfColumnInSection:(NSInteger) section
{
    return MIN(section+1, 5);
}

- (CGFloat) collectionView:(UICollectionView*) collectionView layout:(NounCollectionFlowLayout*) layout itemWidth:(CGFloat) width heightForItemAtIndexPath:(NSIndexPath*) indexPath
{
    NSNumber* number = self.datas[indexPath.section][indexPath.item];
    return [number floatValue];
}

- (UIEdgeInsets) collectionView:(UICollectionView*) collectionView layout:(NounCollectionFlowLayout*) layout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
}

- (CGFloat) collectionView:(UICollectionView*) collectionView  layout:(NounCollectionFlowLayout*) layout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0;
}

- (CGFloat) colletionView:(UICollectionView*) collectionView layout:(NounCollectionFlowLayout*) layout minimumInteritemSpacingForSectionAtIndex:(NSInteger) section
{
    return 10.0;
}

- (CGFloat) collectionView:(UICollectionView*) collectionView layout:(NounCollectionFlowLayout*) layout referenceHeightForHeaderInSection:(NSInteger) section
{
    return 40.0;
}

- (CGFloat) collectionView:(UICollectionView*) collectionView layout:(NounCollectionFlowLayout*) layout referenceHeightForFooterInSection:(NSInteger) section
{
    return 40.0;
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
