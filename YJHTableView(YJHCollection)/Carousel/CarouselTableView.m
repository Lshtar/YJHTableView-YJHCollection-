//
//  CarouselTableView.m
//  Practise2018.6.13
//
//  Created by D on 2018/7/9.
//  Copyright © 2018年 D. All rights reserved.
//

#import "CarouselTableView.h"
#import "CarouselTableViewCell.h"

@interface CarouselTableView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy) NSArray* carouselImageArray;

@end

@implementation CarouselTableView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray
{
    self = [super init];
    if (self) {
        [self setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.carouselImageArray = [NSArray arrayWithArray:imageArray];
        [self creatCarouselTableView];
    }
    return self;
}

- (void) creatCarouselTableView
{
    UITableView* carouselTableV = [[UITableView alloc] initWithFrame:CGRectMake(0, 100, SCREENWidth, SCREENWidth) style:UITableViewStylePlain];
    carouselTableV.delegate = self;
    carouselTableV.dataSource = self;
    carouselTableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    carouselTableV.showsVerticalScrollIndicator = NO;
    carouselTableV.showsHorizontalScrollIndicator = NO;
    carouselTableV.transform = CGAffineTransformMakeRotation(-M_PI/2);
    [self addSubview:carouselTableV];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_carouselImageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* carouselTableCellIdentifier = @"carouselTableCellIdentifier";
    CarouselTableViewCell* carouselTableCell = [tableView dequeueReusableCellWithIdentifier:carouselTableCellIdentifier];
    if (carouselTableCell == nil) {
        carouselTableCell = [[CarouselTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:carouselTableCellIdentifier];
    }
    [carouselTableCell clearCarouselCell];
    NSString* carouselImageName = self.carouselImageArray[indexPath.row];
    [carouselTableCell fillCarouselCellImage:[UIImage imageNamed:carouselImageName]];
    return carouselTableCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.carouselDelegate &&[self.carouselDelegate respondsToSelector:@selector(carouselTableView:didSelectRowAtIndexPath:)]) {
        [self.carouselDelegate carouselTableView:self didSelectRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSIndexPath* shouwIndex = tableView.indexPathsForVisibleRows.lastObject;
    if (self.carouselDelegate && [self.carouselDelegate respondsToSelector:@selector(carouselTableView:didSelectRowAtIndexPath:)]) {
        [self.carouselDelegate showOtherImageIndex:shouwIndex];
    }
}

@end
