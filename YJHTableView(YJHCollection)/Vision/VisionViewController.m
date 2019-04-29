//
//  VisionViewController.m
//  Practise2018.6.13
//
//  Created by D on 2018/6/27.
//  Copyright © 2018年 D. All rights reserved.
//

#import "VisionViewController.h"
#import "VisionCell.h"

@interface VisionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray* sourceArr;
@property (nonatomic, strong) UITableView* visionTable;

@end

@implementation VisionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"视觉差";
    
   
    [self creatVisionTableView];
    
}

- (instancetype) init
{
    self = [super init];
    if (self) {
        _sourceArr = [NSMutableArray array];
        for (NSInteger i = 1; i < 10; i++) {
            NSString* imageName = [NSString stringWithFormat:@"img%ld.jpg",i];
            [_sourceArr addObject:imageName];
        }
    }
    
    return self;
}

- (void) creatVisionTableView
{
    _visionTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCREENWidth, SCREENHeight) style:UITableViewStylePlain];
    _visionTable.dataSource = self;
    _visionTable.delegate = self;
    _visionTable.showsVerticalScrollIndicator = NO;
    _visionTable.showsHorizontalScrollIndicator = NO;
    _visionTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_visionTable];
}

- (void) updateImageViewCellOffset:(VisionCell*) cell
{
    CGFloat cellOffset = cell.frame.origin.y - self.visionTable.contentOffset.y;
    CGFloat imgMaxHeight = [cell imageOverflowHeight];
    CGFloat offset = 0.0f - imgMaxHeight* cellOffset / self.visionTable.frame.size.height;
    
    [cell setImageOffset:CGPointMake(0.0f, offset)];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_sourceArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* visionCellIdentifier = @"visionCellIdentifier";
    VisionCell* visionCell = [tableView dequeueReusableCellWithIdentifier:visionCellIdentifier];
    if (visionCell == nil) {
        visionCell = [[VisionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:visionCellIdentifier];
    }
    visionCell.visionImageView.image = [UIImage imageNamed:[_sourceArr objectAtIndex:indexPath.row]];
    visionCell.clipsToBounds = YES;
    return visionCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

#pragma mark - UIScrollViewdelegate methods

- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    for (VisionCell* cell in self.visionTable.visibleCells) {
        [self updateImageViewCellOffset:cell];
    }
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self updateImageViewCellOffset:(VisionCell *)cell];
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
