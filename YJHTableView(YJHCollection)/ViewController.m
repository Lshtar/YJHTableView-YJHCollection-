//
//  ViewController.m
//  YJHTableView(YJHCollection)
//
//  Created by D on 2018/7/31.
//  Copyright © 2018年 D. All rights reserved.
//

#import "ViewController.h"
#import "YJHPractiseCell.h"
#import "SeleTableViewController.h"
#import "HorizontalViewController.h"
#import "NounViewController.h"
#import "NounHeaderFooterViewController.h"
#import "VisionViewController.h"
#import "FoldawayViewController.h"
#import "FallsViewController.h"
#import "DragViewController.h"
#import "CarouselTableViewController.h"
#import "CarouselViewController.h"
#import "CarouselScrollViewController.h"
#import "ChangeViewController.h"
#import "ChangeNavColorViewController.h"
#import "SwiftModule-Swift.h"
#import "AnimationViewController.h"
#import "PriceViewController.h"
#import "InputViewController.h"
#import "ChartsViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView* tabView;
@property (nonatomic,strong) NSArray *contentAry;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

//    self.contentAry = @[@"哈哈哈",@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈",@"啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈",@"哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈哈哈哈哈哈哈哈哈哈哈啊哈哈哈哈"];
    
      self.contentAry = @[@"两个TableView联动",@"横向滚动",@"瀑布流",@"瀑布流Header悬停",@"视觉差",@"折叠效果",@"两列瀑布流",@"拖动",@"carousel旋转",@"carsouselTableView",@"carsouselScrollView",@"导航栏渐变",@"导航栏颜色渐变",@"Swift横向滚动",@"Swift",@"Animation",@"价钱显示",@"输入限制",@"cahrts"];
   
    [self creatTableView];
}

- (void) creatTableView
{
    _tabView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44) style:UITableViewStylePlain];
    _tabView.dataSource = self;
    _tabView.delegate = self;
    _tabView.showsVerticalScrollIndicator =  NO;
    _tabView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_tabView];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentAry.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 10;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewAutomaticDimension;
//}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* cellIdentifier = @"cellIdenfitifer";
    YJHPractiseCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if (cell == nil) {
        cell = [[YJHPractiseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

//    cell.nameLab.text = self.contentAry[indexPath.row];

        cell.desLab.text = self.contentAry[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        SeleTableViewController* seleTableVController = [[SeleTableViewController alloc] init];
        [self.navigationController pushViewController:seleTableVController animated:YES];
    }else if (indexPath.row == 1)
    {
        HorizontalViewController* horizontalVController = [[HorizontalViewController alloc] init];
        [self.navigationController pushViewController:horizontalVController animated:YES];
    }
    else if (indexPath.row == 2)
    {
        NounViewController* nounVController = [[NounViewController alloc] init];
        [self.navigationController pushViewController:nounVController animated:YES];
    }
    else if (indexPath.row == 3)
    {
        NounHeaderFooterViewController* nounHeaderFooterVController = [[NounHeaderFooterViewController alloc] init];
        [self.navigationController pushViewController:nounHeaderFooterVController animated:YES];
    }
    else if (indexPath.row == 4)
    {
        VisionViewController* visionVController = [[VisionViewController alloc] init];
        [self.navigationController pushViewController:visionVController animated:YES];
    }
    else if (indexPath.row == 5)
    {
        FoldawayViewController* foldawayVController = [[FoldawayViewController alloc] init];
        [self.navigationController pushViewController:foldawayVController animated:YES];
    }
    else if (indexPath.row == 6)
    {
        FallsViewController* fallsVController = [[FallsViewController alloc] init];
        [self.navigationController pushViewController:fallsVController animated:YES];
    }
    else if (indexPath.row == 7)
    {
        DragViewController* dragVController = [[DragViewController alloc] init];
        [self.navigationController pushViewController:dragVController animated:YES];
    }
    else if (indexPath.row == 8)
    {
        CarouselViewController* carouselVController = [[CarouselViewController alloc] init];
        [self.navigationController pushViewController:carouselVController animated:YES];
    }
    else if (indexPath.row == 9)
    {
        CarouselTableViewController* carouselTableVController = [[CarouselTableViewController alloc] init];
        [self.navigationController pushViewController:carouselTableVController animated:YES];
    }
    else if (indexPath.row == 10)
    {
        CarouselScrollViewController* carouselScrollVController = [[CarouselScrollViewController alloc] init];
        [self.navigationController pushViewController:carouselScrollVController animated:YES];
    }
    else if (indexPath.row == 11)
    {
        ChangeViewController* changeVController = [[ChangeViewController alloc] init];
        [self.navigationController pushViewController:changeVController animated:YES];
    }
    else if (indexPath.row == 12)
    {
        ChangeNavColorViewController* changeNavColorVController = [[ChangeNavColorViewController alloc] init];
        [self.navigationController pushViewController:changeNavColorVController animated:YES];
    }else if (indexPath.row == 13)
    {
        SwiftHorizontalViewController* swiftHorizontalVController = [[SwiftHorizontalViewController alloc] init];
        [self.navigationController pushViewController:swiftHorizontalVController animated:YES];
    }else if (indexPath.row == 14)
    {
        ColumnViewController* columnVController = [[ColumnViewController alloc] init];
        [self.navigationController pushViewController:columnVController animated:YES];
    }else if (indexPath.row == 15)
    {
        AnimationViewController* animationVController = [[AnimationViewController alloc] init];
        [self.navigationController pushViewController:animationVController animated:YES];
    }else if (indexPath.row == 16)
    {
        PriceViewController* priceVController = [[PriceViewController alloc] init];
        [self.navigationController pushViewController:priceVController animated:YES];
    }else if (indexPath.row == 17)
    {
        InputViewController* inputVController = [[InputViewController alloc] init];
        [self.navigationController pushViewController:inputVController animated:YES];
    }else if (indexPath.row == 18)
    {
        ChartsViewController* chartsVController = [[ChartsViewController alloc] init];
        [self.navigationController pushViewController:chartsVController animated:YES];
    }
}

// 当cell取消选中状态时
- (void)deselect{
    [self.tabView deselectRowAtIndexPath:[self.tabView indexPathForSelectedRow] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
