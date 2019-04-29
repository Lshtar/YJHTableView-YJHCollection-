//
//  Header.h
//  YJHTableView(YJHCollection)
//
//  Created by D on 2018/7/31.
//  Copyright © 2018年 D. All rights reserved.
//

#ifndef Header_h
#define Header_h

#define SCREENWidth   [UIScreen mainScreen].bounds.size.width
#define SCREENHeight  [UIScreen mainScreen].bounds.size.height

// 判断是否是iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
// 状态栏高度
#define STATUS_BAR_HEIGHT (iPhoneX ? 44.f : 20.f)
// 导航栏高度
#define NAVIGATION_BAR_HEIGHT (iPhoneX ? 88.f : 64.f)
// tabBar高度
#define TAB_BAR_HEIGHT (iPhoneX ? (49.f + 34.f) : 49.f)
// home indicator
#define HOME_INDICATOR_HEIGHT (iPhoneX ? 34.f : 0.f)


#endif /* Header_h */
