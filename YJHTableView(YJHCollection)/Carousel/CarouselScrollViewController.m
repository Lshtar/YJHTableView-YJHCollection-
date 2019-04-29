//
//  CarouselScrollViewController.m
//  Practise2018.6.13
//
//  Created by D on 2018/7/10.
//  Copyright © 2018年 D. All rights reserved.
//

#import "CarouselScrollViewController.h"
#import "CarouselScrollView.h"

@interface CarouselScrollViewController ()

@property (nonatomic,strong) CarouselScrollView* carouselScrollV;
@property (nonatomic,strong) CarouselScrollView* carouselScrollView;

@end

@implementation CarouselScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"carouselScrollView";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatCarouselScrollView];
}

- (void) creatCarouselScrollView
{
#pragma mark - 卡片滚动图
    _carouselScrollV = [CarouselScrollView initWithFrame:CGRectMake(0, 80, SCREENWidth, 100) imageSpacing:10 imageWidth:SCREENWidth - 50];
    _carouselScrollV.initAlpha = 0.5; // 设置两边卡片的透明度
    _carouselScrollV.imageRadius = 10; // 设置卡片圆角
    _carouselScrollV.imageHeightPoor = 10; // 设置中间卡片与两边卡片的高度差
    // 设置要加载的图片
    self.carouselScrollV.data = @[@"http://d.hiphotos.baidu.com/image/pic/item/b7fd5266d016092408d4a5d1dd0735fae7cd3402.jpg",@"http://h.hiphotos.baidu.com/image/h%3D300/sign=2b3e022b262eb938f36d7cf2e56085fe/d0c8a786c9177f3e18d0fdc779cf3bc79e3d5617.jpg",@"http://a.hiphotos.baidu.com/image/pic/item/b7fd5266d01609240bcda2d1dd0735fae7cd340b.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/728da9773912b31b57a6e01f8c18367adab4e13a.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/0d338744ebf81a4c5e4fed03de2a6059242da6fe.jpg"];
    _carouselScrollV.placeHolderImage = [UIImage imageNamed:@""]; // 设置占位图片
    [self.view addSubview:self.carouselScrollV];
    _carouselScrollV.clickImageBlock = ^(NSInteger currentIndex) { // 点击中间图片的回调
        
    };
    
#pragma mark - 普通滚动图
    _carouselScrollView = [CarouselScrollView initWithFrame:CGRectMake(0, 300, SCREENWidth, 150) imageSpacing:0 imageWidth:SCREENWidth];
    _carouselScrollView.clickImageBlock = ^(NSInteger currentIndex) {
        
    };
    _carouselScrollView.placeHolderImage = [UIImage imageNamed:@""]; // 设置占位图片
    self.carouselScrollView.data = @[@"http://d.hiphotos.baidu.com/image/pic/item/b7fd5266d016092408d4a5d1dd0735fae7cd3402.jpg",@"http://h.hiphotos.baidu.com/image/h%3D300/sign=2b3e022b262eb938f36d7cf2e56085fe/d0c8a786c9177f3e18d0fdc779cf3bc79e3d5617.jpg",@"http://a.hiphotos.baidu.com/image/pic/item/b7fd5266d01609240bcda2d1dd0735fae7cd340b.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/728da9773912b31b57a6e01f8c18367adab4e13a.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/0d338744ebf81a4c5e4fed03de2a6059242da6fe.jpg"];
    [self.view addSubview:self.carouselScrollView];
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
