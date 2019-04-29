//
//  SeleTableViewController.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/13.
//  Copyright © 2018年 D. All rights reserved.
//

#import "SeleTableViewController.h"
#import "SeleTitleCell.h"
#import "SeleTableCell.h"

@interface SeleTableViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat _originX;
    CGFloat _originY;
}

@property (nonatomic, strong) UITableView* titleTableView;
@property (nonatomic, strong) UITableView* seleContentTableView;
@property (nonatomic, strong) UIScrollView* seleContentView;

@end

@implementation SeleTableViewController

- (UILabel*) quickCreatLabelWithLeft:(CGFloat) left width:(CGFloat) width title:(NSString*)title
{
    UILabel* lab = [[UILabel alloc] initWithFrame:CGRectMake(left, 10, width, 40)];
    lab.text = title;
    lab.textAlignment = NSTextAlignmentCenter;
    return lab;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"两个tableView联动";
    
    [self creatSeleTableView];
}

- (void) creatSeleTableView
{
    _originX = 100;
    _originY = 50;
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UILabel* titleLab = [self quickCreatLabelWithLeft:0 width:_originX title:@"名字"];
    titleLab.frame = CGRectMake(0, 64, 100, 50);
    titleLab.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:titleLab];
    
    _seleContentView = [[UIScrollView alloc] initWithFrame:CGRectMake(_originX, 64, width-_originX, height)];
    _seleContentView.contentSize = CGSizeMake(width, height);
    _seleContentView.backgroundColor = [UIColor redColor];
    _seleContentView.bounces = NO;
    _seleContentView.delegate = self;
    [self.view addSubview:_seleContentView];
    
    _titleTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _originY+64, 100, height)style:UITableViewStylePlain];
    _titleTableView.delegate = self;
    _titleTableView.dataSource = self;
    _titleTableView.showsVerticalScrollIndicator = NO;
    _titleTableView.showsHorizontalScrollIndicator = NO;
    _titleTableView.tableFooterView = [UIView new];
    [self.view addSubview:self.titleTableView];
    
    _seleContentTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _originY, width, height-_originY)style:UITableViewStylePlain];
    _seleContentTableView.delegate = self;
    _seleContentTableView.dataSource = self;
    _seleContentTableView.showsVerticalScrollIndicator = NO;
    _seleContentTableView.showsHorizontalScrollIndicator = NO;
    _seleContentTableView.tableFooterView = [UIView new];
    [_seleContentView addSubview:self.seleContentTableView];
    
    for (int i = 0; i < 5; i++) {
        CGFloat x = i * 100;
        UILabel* lab = [self quickCreatLabelWithLeft:x width:100 title:[NSString stringWithFormat:@"title%d",i]];
        [_seleContentView addSubview:lab];
    }
    
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
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.titleTableView) {
        SeleTitleCell* seleTitleCell = [tableView dequeueReusableCellWithIdentifier:@"seleTitleCellIdentifier"];
        if (seleTitleCell == nil) {
            seleTitleCell = [[SeleTitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"seleTitleCellIdentifier"];
        }
        
        return seleTitleCell;
    }else
    {
      SeleTableCell* seleCell = [tableView dequeueReusableCellWithIdentifier:@"seleCellIdentifier"];
        if (seleCell == nil) {
            seleCell = [[SeleTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"seleCellIdentifier"];
      }
        
    return seleCell;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == _titleTableView) {
        [_seleContentTableView setContentOffset:CGPointMake(_seleContentTableView.contentOffset.x, _titleTableView.contentOffset.y)];
    }else if (scrollView == _seleContentTableView){
        [_titleTableView setContentOffset:CGPointMake(0, _seleContentTableView.contentOffset.y)];
    }
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
