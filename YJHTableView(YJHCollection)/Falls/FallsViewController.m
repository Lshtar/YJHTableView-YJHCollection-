//
//  FallsViewController.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/28.
//  Copyright © 2018年 D. All rights reserved.
//

#import "FallsViewController.h"
#import "FallsCollectionCell.h"
#import "FallsCollectionLayout.h"

@interface FallsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,FallsCollectionLayoutDelegate>

@end

@implementation FallsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"两列瀑布流";
    
    self.navigationController.navigationBar.translucent = NO;
    [self creatFallsCollectionView];
    
}

- (void) creatFallsCollectionView
{
    FallsCollectionLayout* fallsLFlowLayout = [[FallsCollectionLayout alloc] init];
    fallsLFlowLayout.columnCount = 2;
    fallsLFlowLayout.columnSpacing = 10;
    fallsLFlowLayout.rowSpacing = 10;
    //
    fallsLFlowLayout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    fallsLFlowLayout.delegate = self;
    
    UICollectionView* fallsCollectionV = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREENWidth, SCREENHeight) collectionViewLayout:fallsLFlowLayout];
    [fallsCollectionV registerClass:[FallsCollectionCell class] forCellWithReuseIdentifier:@"fallsCollectionCellIdentifier"];
    fallsCollectionV.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    fallsCollectionV.backgroundColor = [UIColor whiteColor];
    fallsCollectionV.delegate = self;
    fallsCollectionV.dataSource = self;
    [self.view addSubview:fallsCollectionV];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FallsCollectionCell* fallsCollectionCell = (FallsCollectionCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"fallsCollectionCellIdentifier" forIndexPath:indexPath];
    if (fallsCollectionCell == nil) {
       
    }
   
    return fallsCollectionCell;
}

- (CGFloat)fallsCollection:(FallsCollectionLayout *)fallsCollectionLayout itemHeightForWidth:(CGFloat)itemWidth atIndexPath:(NSIndexPath *)indextPath
{
    return arc4random() % 50 + 100;
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
