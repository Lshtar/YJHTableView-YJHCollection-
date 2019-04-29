//
//  FoldawayViewController.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/27.
//  Copyright © 2018年 D. All rights reserved.
//

#import "FoldawayViewController.h"
#import "FoldawayCell.h"
#import "FoldawayView.h"

@interface FoldawayViewController ()<UITableViewDelegate,UITableViewDataSource, foldawaynHeaderViewDelegate>

@property (nonatomic, strong) UITableView* foldawayTableV;
//保存所有的头部视图
@property (nonatomic, copy) NSMutableArray* headViewArray;
//数据源
@property (nonatomic, copy) NSMutableArray* dataArray;

@end

@implementation FoldawayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"折叠";
    
   // self.automaticallyAdjustsScrollViewInsets = NO;
    //请求数据
    [self requestData];
    //创建tableView
    [self creatTableView];
    //创建section的头部视图
    [self creatFoldawayHeadView];
}

-(void)requestData
{
    _dataArray = [NSMutableArray array];

}

-(void)creatFoldawayHeadView
{
    _headViewArray = [[NSMutableArray alloc] init];
    
    //循环创建5个头部视图，把5个视图依此加入到一个数组里
    for (int i = 0; i<_dataArray.count; i++) {
        FoldawayView *headView = [[FoldawayView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
        [headView.btn setTitle:[NSString stringWithFormat:@"%d组",i+1] forState:UIControlStateNormal];
        //指定代理对象
        headView.foldawayDelegate = self;
        [_headViewArray  addObject:headView];
    }
    
}

-(void)creatTableView
{
    _foldawayTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64) style:UITableViewStyleGrouped];
    _foldawayTableV.delegate = self;
    _foldawayTableV.dataSource = self;
    _foldawayTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    _foldawayTableV.showsVerticalScrollIndicator = NO;
    _foldawayTableV.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_foldawayTableV];
    
}

#pragma mark - UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    FoldawayView *view = _headViewArray[section];
    return view.isAppear?[_dataArray[section] count]:0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* foldawayCellIdentifier = @"foldawayCellIdentifier";
    FoldawayCell* foldawayCell = [tableView  dequeueReusableCellWithIdentifier:foldawayCellIdentifier forIndexPath:indexPath];
    if (foldawayCell == nil) {
        foldawayCell = [[FoldawayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:foldawayCellIdentifier];
    }

    foldawayCell.foldawayImaV.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",_dataArray[indexPath.section]]];
    foldawayCell.foldawayLabel.text = [NSString stringWithFormat:@"%@",_dataArray[indexPath.section][indexPath.row]];
    
    return foldawayCell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return _headViewArray[section];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - SectionHeaderViewDelegate

-(void)changedIsAppear
{
    //刷新tableView
    [_foldawayTableV  reloadData];
    
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
