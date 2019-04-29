//
//  CarouselTableViewController.m
//  Practise2018.6.13
//
//  Created by D on 2018/7/9.
//  Copyright © 2018年 D. All rights reserved.
//

#import "CarouselTableViewController.h"
#import "CarouselTableView.h"

@interface CarouselTableViewController ()<carouselTableViewDelegate>

@property (nonatomic, copy) NSArray* carouselImageArray;
@property (nonatomic, weak) UIImageView* otherImageV;

@end

@implementation CarouselTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"carsouselTableView";
    
    [self creatInterface];
}

- (void) creatInterface
{
    
    NSArray *imageArray = [NSArray arrayWithObjects:@"img1.jpg",@"img2.jpg",@"img3.jpg",@"img4.jpg",@"img5.jpg",@"img6.jpg",@"img7.jpg",@"img8.jpg",@"img9.jpg",@"img10.jpg", nil];
    self.carouselImageArray = [NSArray arrayWithArray:imageArray];
    
    CarouselTableView* carouselTableV = [[CarouselTableView alloc]initWithFrame:CGRectMake(0, 0, SCREENWidth, 150) imageArray:self.carouselImageArray];
    carouselTableV.carouselDelegate = self;
    [self.view addSubview:carouselTableV];
    
    //
    UIImageView* otherImageV = [[UIImageView alloc]initWithFrame:CGRectMake((SCREENWidth-300)/2, 400, 300, 150)];
    self.otherImageV = otherImageV;
    [self.view addSubview:otherImageV];
}

- (void)carouselTableView:(CarouselTableView *)carouselTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"didSelect row = %ld",indexPath.row);
}

- (void)showOtherImageIndex:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row -1;
    NSString *imageName = self.carouselImageArray[index];
    self.otherImageV.image = [UIImage imageNamed:imageName];
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
