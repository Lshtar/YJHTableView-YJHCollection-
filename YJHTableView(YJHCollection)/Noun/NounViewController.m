//
//  NounViewController.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/14.
//  Copyright © 2018年 D. All rights reserved.
//

#import "NounViewController.h"
#import "NounCell.h"
#import "NounCollectionCell.h"
#import "NounCollectionFlowLayout.h"

@interface NounViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,NounCollectionFlowLayoutDataSource>
{
    NSMutableArray* arrData;
    NSMutableArray* arrData1;
    NSMutableArray* arrData2;
    NSMutableArray* arrData1_1;
    NSMutableArray* arrData2_2;
    
    float he1,he2;
}

@property (nonatomic, weak) UITableView* nounTableView1;
@property (nonatomic, weak) UITableView* nounTableView2;

@property (nonatomic, strong) NSMutableArray<NSMutableArray<NSNumber*>*>* datas;

@end

@implementation NounViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"瀑布流";
    
    //nounTableView 瀑布流
    // [self creatNounTableView];
    
    //nounCollectionView 瀑布流
    [self nounCollectionViewInit];
    [self creatNounCollectionView];
    
}

- (void) creatNounTableView
{
    he1 = 0.0;
    he2 = 0.0;
    arrData1 = [[NSMutableArray alloc] initWithCapacity:1];
    arrData2 = [[NSMutableArray alloc] initWithCapacity:1];
    arrData1_1 = [[NSMutableArray alloc] initWithCapacity:1];
    arrData2_2 = [[NSMutableArray alloc] initWithCapacity:1];
    for (int i = 0; i < 11; i++) {
        NSString* nounStr = [NSString stringWithFormat:@"%d",i];
        float hecu;
        
        if (he2 >= he1) {
            he1 = he1 + hecu;
            
            NSArray* arr = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",i],[NSString stringWithFormat:@"%f",hecu], nil];
            
            [arrData1 addObject:arr];
        }else
        {
            he2 = he2 + hecu;
            NSArray* arr = [[NSArray alloc] initWithObjects:[NSString stringWithFormat:@"%d",i],[NSString stringWithFormat:@"%f",hecu], nil];
            [arrData2 addObject:arr];
        }
         NSLog(@"%f(h1 = %f,,,,h2 = %f)",hecu,he1,he2);
    }
    _nounTableView1.showsVerticalScrollIndicator = NO;
    _nounTableView2.showsVerticalScrollIndicator = NO;
    
    NSLog(@"%@+++++++%@",arrData1,arrData2);
    
    
}

- (instancetype) nounCollectionViewInit
{
    _datas = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        NSMutableArray<NSNumber*>* section = [NSMutableArray array];
        for (int j = 0; j<20; j++) {
            CGFloat height = arc4random_uniform(100) + 30.0;
            [section addObject:@(height)];
        }
        [_datas addObject:section];
    }
    return nil;
}

- (void) creatNounCollectionView
{
    CGRect nounCollectionViewFrame = CGRectMake(0, 64, SCREENWidth, SCREENHeight);
    
    UICollectionViewFlowLayout* nounFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    UICollectionView* nounCollectionView = [[UICollectionView alloc] initWithFrame:nounCollectionViewFrame collectionViewLayout:nounFlowLayout];
    nounCollectionView.backgroundColor = [UIColor whiteColor];
    nounCollectionView.delegate = self;
    nounCollectionView.dataSource = self;
    [self.view addSubview:nounCollectionView];
    
    [nounCollectionView registerClass:[NounCollectionCell class] forCellWithReuseIdentifier:@"nounCollectionCellIdentifier"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _nounTableView1) {
        return [arrData1 count];
    }else
    {
        return [arrData2 count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (tableView == _nounTableView1) {
        static NSString* nounCellIdentifier1 = @"nounCellIdentifier1";
        NounCell* nounCell1 = [tableView dequeueReusableCellWithIdentifier:nounCellIdentifier1];
        if (nounCell1 == nil) {
            nounCell1 = [[NounCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nounCellIdentifier1];
        }
        nounCell1.backgroundColor = [UIColor purpleColor];
//        nounCell1.textLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
        nounCell1.textLabel.text= @"tableview竖向滚动";
        return nounCell1;
    }
    static NSString* nounCellIdentifier = @"nounCellIdentifier";
    NounCell* nounCell = [tableView dequeueReusableCellWithIdentifier:nounCellIdentifier];
    if (nounCell == nil) {
        nounCell = [[NounCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nounCellIdentifier];
    }
    nounCell.backgroundColor = [UIColor purpleColor];
    nounCell.textLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
    nounCell.textLabel.text= @"tableview竖向滚动";
    return nounCell;
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
    
    NounCollectionCell* nounCollectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"nounCollectionCellIdentifier" forIndexPath:indexPath];
    if (nounCollectionCell == nil) {
        nounCollectionCell.textLabel.text = [NSString stringWithFormat:@"{%ld,%ld}", indexPath.section, indexPath.item];
    }
    nounCollectionCell.backgroundColor= [UIColor brownColor];
    return nounCollectionCell;
}

#pragma mark <UICollectionViewDelegate>

#pragma mark <XPCollectionViewWaterfallFlowLayoutDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView layout:(NounCollectionFlowLayout *)layout numberOfColumnInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(NounCollectionFlowLayout*)layout itemWidth:(CGFloat)width heightForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber* number = self.datas[indexPath.section][indexPath.item];
    return [number floatValue];
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
