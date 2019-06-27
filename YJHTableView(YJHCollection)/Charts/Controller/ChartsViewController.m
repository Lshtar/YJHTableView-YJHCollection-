//
//  ChartsViewController.m
//  YJHTableView(YJHCollection)
//
//  Created by D on 2019/5/10.
//  Copyright © 2019 D. All rights reserved.
//

#import "ChartsViewController.h"
#import "YJHChartView.h"

@interface ChartsViewController ()

@property (nonatomic, strong) YJHChartView *chartView;

@end

@implementation ChartsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.view.backgroundColor = [UIColor cyanColor];
    
    //
    //    _chartView = [[ORChartView alloc]initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 300) countFoyY:7];
    
    
    _chartView = [[YJHChartView alloc]initWithFrame:CGRectMake(0, 150, [UIScreen mainScreen].bounds.size.width, 300) dataSource:@[@"123",@"88", @"45",@"33"] countFoyY:7];
    
    _chartView.titleForX = @"日期/日";
    _chartView.titleForY = @"收益/元";
    
    [_chartView pointDidTapedCompletion:^(NSString *value, NSInteger index) {
        NSLog(@"....%@....%ld", value, (long)index);
    }];
    
    [self.view addSubview:_chartView];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    /*
     随机数据源
     随机样式
     随机颜色
     */
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 20; i ++) {
        NSInteger num = arc4random() % 3000;
        [array addObject:[NSString stringWithFormat:@"%ld",(long)num]];
    }
    
    _chartView.dataSource = [array copy];
    _chartView.style = arc4random() % 4;
    
    _chartView.lineColor = [UIColor colorWithRed:arc4random() % 255 /255.f green:arc4random() % 255 /255.f blue:arc4random() % 255 /255.f alpha:1];
    
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
