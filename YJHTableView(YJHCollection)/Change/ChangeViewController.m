//
//  ChangeViewController.m
//  Practise2018.6.13
//
//  Created by D on 2018/7/5.
//  Copyright © 2018年 D. All rights reserved.
//

#import "ChangeViewController.h"
#import "UIImage+Color.h"

#define HeadViewHeight 200 // 头视图高度
#define SuspensionViewHeight 44 // 悬浮视图高度
#define HeadViewMinHeight 64 // HeadView最小高度

@interface ChangeViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>

/** HeadView高度约束 */
@property (weak, nonatomic) NSLayoutConstraint *headHeightCons;
/** 导航栏标题 */
@property (nonatomic, weak) UILabel *userNameLabel;
/** 记录滚动视图最开始偏移量y值 */
@property (nonatomic, assign) CGFloat oriOffsetY;

@property (nonatomic, strong) UITableView* changeTableV;

@property (nonatomic, strong) UIImageView* backImage;

@property (nonatomic, strong) UIImageView* userIcon;

@end

@implementation ChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 设置导航条
    [self setUpNavigationBar];
    
    // 不需要自动调节滚动区域
    self.extendedLayoutIncludesOpaqueBars = YES;
    if (@available(iOS 11.0, *)) {
        self.changeTableV.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _changeTableV.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    _changeTableV.scrollIndicatorInsets = _changeTableV.contentInset;

    
    // 记录最开始偏移量y值
    _oriOffsetY = -(HeadViewHeight + SuspensionViewHeight);
    
    // 设置tableView顶部额外滚动区域
    self.changeTableV.contentInset = UIEdgeInsetsMake(-_oriOffsetY, 0, 0, 0);
    
    [self creatHeadView];
    [self creatChangeView];
}

/** 设置导航栏 */
- (void)setUpNavigationBar {
    // 传递一个空的UIImage,选择模式为UIBarMetricsDefault来设置导航栏背景为透明, 注意UIImage不能传nil, 如果传nil, 苹果会为你加载一张默认的不透明背景图片
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    
    // 清空导航条的阴影的线
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    // 设置导航条标题为透明
    UILabel *usernameLabel = [[UILabel alloc] init];
    usernameLabel.text = @"导航栏渐变";
    // 设置文字的颜色
    usernameLabel.textColor = [UIColor colorWithWhite:1 alpha:0];
    // 根据文字大小自适应尺寸
    [usernameLabel sizeToFit];
    _userNameLabel = usernameLabel;
    
    [self.navigationItem setTitleView:_userNameLabel];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 获取当前偏移量y值
    CGFloat curOffsetY = scrollView.contentOffset.y;
    
    // 计算偏移量的差值
    CGFloat delta = curOffsetY - _oriOffsetY;
    
    // 计算头部视图的高度
    CGFloat h = HeadViewHeight - delta;
    if (h < HeadViewMinHeight) {
        h = HeadViewMinHeight;
    }
    
    // 修改HeadView高度
    _headHeightCons.constant = h;
    
    // 处理导航条业务逻辑
    
    // 计算透明度
    CGFloat alpha = delta / (HeadViewHeight - HeadViewMinHeight);
    
    if (alpha > 1) {
        alpha = 0.99;
    }
    
    // 设置导航条背景图片
    // 根据当前alpha值生成图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:alpha]];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    // 设置导航条标题颜色
    _userNameLabel.textColor = [UIColor colorWithWhite:0 alpha:alpha];
}

- (void) creatHeadView
{
    self.view.backgroundColor = [UIColor whiteColor];
    UIView* headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    [self.view addSubview:headView];
    
    self.backImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
    self.backImage.image = [UIImage imageNamed:@"img1.jpg"];
    self.backImage.contentMode = UIViewContentModeScaleAspectFill;
    [headView addSubview:_backImage];
    
    self.userIcon = [[UIImageView alloc] initWithFrame:CGRectMake((SCREENWidth- 100)/2, 64, 100, 100)];
    self.userIcon.backgroundColor = [UIColor purpleColor];
    [headView addSubview:self.userIcon];
    
    UIView* suspensionView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, SCREENWidth, 44)];
    suspensionView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:suspensionView];
}

- (void) creatChangeView
{
    _changeTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 244, SCREENWidth, SCREENHeight-244) style:UITableViewStylePlain];
    _changeTableV.delegate = self;
    _changeTableV.dataSource = self;
    _changeTableV.showsHorizontalScrollIndicator = NO;
    _changeTableV.showsVerticalScrollIndicator = NO;
    _changeTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_changeTableV];
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
    static NSString* changeCellIdentifier = @"changeCellIdentifier";
    UITableViewCell* changeCell = [tableView dequeueReusableCellWithIdentifier:changeCellIdentifier];
    if (changeCell == nil) {
        changeCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:changeCellIdentifier];
    }
    changeCell.textLabel.text = [NSString stringWithFormat:@"%d", (int)indexPath.row];
    return changeCell;
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
