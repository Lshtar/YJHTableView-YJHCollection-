//
//  PriceViewController.m
//  YJHTableView(YJHCollection)
//
//  Created by D on 2019/5/7.
//  Copyright © 2019 D. All rights reserved.
//

#import "PriceViewController.h"

@interface PriceViewController ()

@end

@implementation PriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"价钱显示样式";
    
    //价钱显示样式
    [self setupPirceView];
}

- (void) setupPirceView
{
    UILabel* priceLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 30)];
    priceLabel.backgroundColor = [UIColor lightGrayColor];
    priceLabel.numberOfLines = 0;
    [self.view addSubview:priceLabel];
    NSMutableAttributedString * noteStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"￥100.%@",@"00"]];
    
    NSRange redRangeTwo = NSMakeRange([[noteStr string] rangeOfString:@"."].location, [[noteStr string] rangeOfString:@"."].length+2);
    
    [noteStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:redRangeTwo];
    
    [priceLabel setAttributedText:noteStr];
    // 创建Attributed
    NSMutableAttributedString *noteStrs = [[NSMutableAttributedString alloc] initWithString:priceLabel.text];
    // 需要改变的第一个文字的位置
    NSUInteger firstLoc = [[noteStrs string] rangeOfString:@"金"].location + 1;
    // 需要改变的最后一个文字的位置
    NSUInteger secondLoc = [[noteStrs string] rangeOfString:@"元"].location;
    // 需要改变的区间
    NSRange range = NSMakeRange(firstLoc, secondLoc - firstLoc);
    // 改变颜色
    [noteStrs addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:range];
    // 改变字体大小及类型
    [noteStrs addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Helvetica-BoldOblique" size:27] range:range];
    // 为label添加Attributed
    [priceLabel setAttributedText:noteStrs];
    
    
    [priceLabel sizeToFit];
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
