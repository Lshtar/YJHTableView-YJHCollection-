//
//  CarouselViewController.m
//  Practise2018.6.13
//
//  Created by D on 2018/7/4.
//  Copyright © 2018年 D. All rights reserved.
//

#import "CarouselViewController.h"
#import "CarouselView.h"


@interface CarouselViewController ()<carouselViewDelegate>

@property (nonatomic, strong) UIImageView* carouselImageV;

@end

@implementation CarouselViewController

/**
 初始化数据
 
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
      
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Carousel";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatCarouselView];
}

- (void) creatCarouselView
{
    self.carouselImageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300,  self.view.bounds.size.width, 300)];
    self.carouselImageV.image = [UIImage imageNamed:@"img1.jpg"];
    [self.view addSubview:self.carouselImageV];

    CarouselView* carouselV =[[CarouselView alloc]initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 100)];
    carouselV.dataSource = @[@"img1.jpg",@"img2.jpg",@"img3.jpg",@"img4.jpg",@"img5.jpg",@"img6.jpg",@"img7.jpg",@"img8.jpg",@"img9.jpg",@"img10.jpg"];
    carouselV.delegate = self;
    [self.view addSubview:carouselV];
    
    carouselV.imageHolderName = @"img1.jpg";
    [self.view addSubview:carouselV];
}

- (void)carouselView:(CarouselView *)carouselView didShowItemAtIndex:(NSInteger)itemIndex
{
    self.carouselImageV.image = [UIImage imageNamed:carouselView.dataSource[itemIndex]];

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
