//
//  AnimationViewController.m
//  YJHTableView(YJHCollection)
//
//  Created by D on 2018/10/15.
//  Copyright © 2018年 D. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController ()

@property (nonatomic, strong) UIButton* but;


@property (nonatomic, strong) LOTAnimationView* animationV;

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"动画";
    
    [self setupAnimation];
    
    /*
     动画 lottie
     **/
    //    [self setupView];
}


- (void) setupView
{
    _animationV = [LOTAnimationView animationNamed:@"690x340fanian_aryouxishijie_banner"];
    _animationV.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-44);
    _animationV.loopAnimation = YES;
    [_animationV play];
    [self.view addSubview:_animationV];
}

- (void) setupAnimation
{
    _but = [UIButton buttonWithType:UIButtonTypeCustom];
    _but.layer.borderColor = [UIColor cyanColor].CGColor;
    _but.layer.borderWidth = 0.5f;
    [_but.layer setCornerRadius:7.0f];
    _but.frame = CGRectMake(100, 200, 100, 80);
    [self.view addSubview:_but];
    
    [_but addTarget:self action:@selector(pressedEvent:) forControlEvents:UIControlEventTouchUpInside];
    [_but addTarget:self action:@selector(unpressedEvent:) forControlEvents:UIControlEventTouchUpOutside];
    
    
}

- (void) pressedEvent:(UIButton*) sender
{
//    [_but setAdjustsImageWhenDisabled:NO];
//
//    UIImageView* imageV = _but.imageView;
//    //设置动画帧
//
//    imageV.animationImages=[NSArray arrayWithObjects:[UIImage imageNamed:@"loading_0"],[UIImage imageNamed:@"loading_1"],[UIImage imageNamed:@"loading_2"],[UIImage imageNamed:@"loading_3"],[UIImage imageNamed:@"loading_4"],[UIImage imageNamed:@"loading_5"],[UIImage imageNamed:@"loading_6"],[UIImage imageNamed:@"loading_7"],[UIImage imageNamed:@"loading_8"],nil];
//
//    //设置动画总时间
//         imageV.animationDuration=1.0;
//         //设置重复次数，0表示无限
//         imageV.animationRepeatCount = 5;
//         //开始动画
//         if (! imageV.isAnimating) {
//               [imageV startAnimating];
//             }
//         [self performSelector:@selector(stopButtonAnimation) withObject:nil afterDelay:5.0];
    
    UIButton *btn = sender;
    NSArray *imgArray = [NSArray arrayWithObjects:[UIImage imageNamed:@"loading_0"],[UIImage imageNamed:@"loading_1"],[UIImage imageNamed:@"loading_2"],[UIImage imageNamed:@"loading_3"],nil];//定义一个动画的帧数组
    UIImageView *animImgView = [[UIImageView alloc]init];//初始化一个UIImageView用于逐帧播放我们的动画
    animImgView.frame = CGRectMake(0, 0, ((UIImage*)[imgArray objectAtIndex:0]).size.width, ((UIImage*)[imgArray objectAtIndex:0]).size.height);//这里默认认为动画的每帧大小是一致的，顾取出第一个图片的大小来作为UIImageView的大小
    animImgView.center = btn.center;//上边只是这是了UIImageView的大小，这里设置他的摆放位置，让动画的中心点和按钮的中心点重叠
    animImgView.tag = 10000;//设置这个是为了在压下的按钮触发的释放动作中获取到这个播放动画的UIImageView
    animImgView.animationImages = imgArray; //将逐帧动画的数组传递给UIImageView
    animImgView.animationDuration = 1; //浏览所有图片一次所用的时间
    animImgView.animationRepeatCount = 0; // 0 = loops forever 动画重复次数
    [animImgView startAnimating]; //开始播放动画
    [self.view addSubview:animImgView]; //添加视图到窗体中
    [self.view sendSubviewToBack:animImgView];//将动画播放的视图移到elf.view的最底层，这里需要注意图层遮挡问题
//
}

-(void)unpressedEvent:(id)sender
{//按钮的松开事件的响应方法
    [[self.view viewWithTag:10000] removeFromSuperview];
}

//- (void)stopButtonAnimation{
//
//    if ([_but.imageView isAnimating]) {
//
//        [_but.imageView stopAnimating];
//
//    }
//
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
