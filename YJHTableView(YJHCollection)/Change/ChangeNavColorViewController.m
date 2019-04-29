//
//  ChangeNavColorViewController.m
//  Practise2018.6.13
//
//  Created by D on 2018/7/6.
//  Copyright © 2018年 D. All rights reserved.
//

#import "ChangeNavColorViewController.h"


#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]

#define RGB(r,g,b) RGBA(r,g,b,1.0f)

#define ZhuTiColor RGB(76,16,198)

#define ZhuTiColorAlpha(alpha) RGBA(76, 16, 198, alpha)

@interface ChangeNavColorViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic,strong) UIImageView *headImage;

@property (nonatomic, strong) UIView *headerBackView;

@property (nonatomic, strong) UIView *mengView;

@property (nonatomic, strong) UITableView* changeNavTableView;

@end

@implementation ChangeNavColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"导航栏颜色渐变";
    
    [self creatNavColorTableView];
}

- (void) creatNavColorTableView
{
    _changeNavTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREENWidth, SCREENHeight) style:UITableViewStylePlain];
    _changeNavTableView.delegate = self;
    _changeNavTableView.dataSource = self;
    _changeNavTableView.showsHorizontalScrollIndicator = NO;
    _changeNavTableView.showsVerticalScrollIndicator = NO;
    _changeNavTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_changeNavTableView];
    
    self.changeNavTableView.tableHeaderView = self.headerBackView;
    
    [self.headerBackView addSubview:self.headImage];
    
    [self.headImage addSubview:self.mengView];
    
    [self navCleanFromAlpha:0];
    
}

-(void)navCleanFromAlpha:(CGFloat)alpha
{
    [self.navigationController.navigationBar setBackgroundImage:[self createImageWithColor:ZhuTiColorAlpha(alpha)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

-(UIImage*) createImageWithColor:(UIColor*) color
{
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

-(UIImageView *)headImage
{
    if(!_headImage)
    {
        _headImage= [[UIImageView alloc]initWithFrame: self.headerBackView.bounds];
        _headImage.image = [UIImage imageNamed:@"1024"];
    }
    return _headImage;
}

-(UIView *)mengView
{
    if (!_mengView)
    {
        _mengView = [[UIView alloc]initWithFrame:self.headerBackView.bounds];
        _mengView.backgroundColor = RGBA(1, 1, 1, 0.1);
    }
    return _mengView;
}

-(UIView *)headerBackView
{
    if (!_headerBackView)
    {
        _headerBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWidth, 200)];
        [_headerBackView setBackgroundColor:[UIColor lightGrayColor]];
    }
    return _headerBackView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* changeNavCellIdentifier = @"changeNavCellIdentifier";
    UITableViewCell* changeNavCell = [tableView dequeueReusableCellWithIdentifier:changeNavCellIdentifier];
    if (changeNavCell == nil) {
        changeNavCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changeNavCellIdentifier];
    }
    changeNavCell.textLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row];
    return changeNavCell;

}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //---------------------- 图片拉升 -------------------------
    //图片高度
    CGFloat imageHeight = self.headerBackView.frame.size.height;
    //图片宽度
    CGFloat imageWidth = SCREENWidth;
    //图片上下偏移量
    CGFloat imageOffsetY = scrollView.contentOffset.y;
    //    NSLog(@"图片上下偏移量 imageOffsetY:%f ->",imageOffsetY);
    //上移
    if (imageOffsetY < 0)
    {
        CGFloat totalOffset = imageHeight + ABS(imageOffsetY);
        CGFloat f = totalOffset / imageHeight;
        self.headImage.frame = CGRectMake(-(imageWidth * f - imageWidth) * 0.5, imageOffsetY, imageWidth * f, totalOffset);
        self.mengView.frame = self.headImage.bounds;
    }
    //------------------- 导航条颜色渐变 ----------------------------
    CGFloat tableViewOffsetY = [self.changeNavTableView rectForSection:0].origin.y - NAVIGATION_BAR_HEIGHT;
    CGFloat contentOffsetY = scrollView.contentOffset.y;
    if (contentOffsetY >= tableViewOffsetY)
    {
        //        scrollView.contentOffset = CGPointMake(0, tableViewOffsetY); //定位
        [self navCleanFromAlpha:1];
    }
    else
    {
        CGFloat alpha = scrollView.contentOffset.y/200;
        if (alpha >= 1) {  alpha = 1;  }
        if (alpha <= 0) {  alpha = 0;  }
        NSLog(@"%.2f",alpha);
        [self navCleanFromAlpha:alpha];
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
