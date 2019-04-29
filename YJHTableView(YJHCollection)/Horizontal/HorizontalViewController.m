//
//  HorizontalViewController.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/14.
//  Copyright © 2018年 D. All rights reserved.
//

#import "HorizontalViewController.h"
#import "HorizontalTableViewCell.h"
#import "HorizontalCollectionViewCell.h"

@interface HorizontalViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation HorizontalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"横向滚动";
    
    //horizontalTableView 横向滚动
    [self creatHorizontalTableView];
    
    //horizontalCollectionView 横向滚动
    [self creatHorizontalCollectionView];
}

- (void) creatHorizontalTableView
{
    UITableView* horizontalTableView = [[UITableView alloc] initWithFrame:CGRectMake(40, 64, 300, SCREENWidth) style:UITableViewStylePlain];
    horizontalTableView.delegate = self;
    horizontalTableView.dataSource = self;
    horizontalTableView.transform = CGAffineTransformMakeRotation(-M_PI / 2);
    horizontalTableView.showsVerticalScrollIndicator = NO;
    //horizontalTableView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:horizontalTableView];
}

- (void) creatHorizontalCollectionView
{
    CGRect horizontalCollectionViewFrame = CGRectMake(0, 500, SCREENWidth, 100);
    
    UICollectionViewFlowLayout* horizontalFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    //设置UICollectionView为横向滚动
    horizontalFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //每一行cell之间的间距
    horizontalFlowLayout.minimumLineSpacing = 30;
    // 每一列cell之间的间距
    // flowLayout.minimumInteritemSpacing = 10;
    // 设置第一个cell和最后一个cell,与父控件之间的间距
    horizontalFlowLayout.sectionInset = UIEdgeInsetsMake(0, 20, 0, 20);
    
    UICollectionView* horizontalCollectionView = [[UICollectionView alloc] initWithFrame:horizontalCollectionViewFrame collectionViewLayout:horizontalFlowLayout];
    horizontalCollectionView.backgroundColor = [UIColor blackColor];
    horizontalCollectionView.delegate = self;
    horizontalCollectionView.dataSource = self;
    [self.view addSubview:horizontalCollectionView];
    
    [horizontalCollectionView registerClass:[HorizontalCollectionViewCell class] forCellWithReuseIdentifier:@"nounCollectionCellIdentifier"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* horizontalCellIdentifier = @"nounCellIdentifier";
    HorizontalTableViewCell* horizontalCell = [tableView dequeueReusableCellWithIdentifier:horizontalCellIdentifier];
    if (horizontalCell == nil) {
        horizontalCell = [[HorizontalTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:horizontalCellIdentifier];
    }
    horizontalCell.backgroundColor = [UIColor purpleColor];
    horizontalCell.textLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
    horizontalCell.textLabel.text= @"tableview竖向滚动";
    return horizontalCell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HorizontalCollectionViewCell* horizontalCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nounCollectionCellIdentifier" forIndexPath:indexPath];
    if (horizontalCollectionCell == nil) {
        horizontalCollectionCell = [[HorizontalCollectionViewCell alloc] init];
    }
    horizontalCollectionCell.backgroundColor= [UIColor brownColor];
    return horizontalCollectionCell;
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
