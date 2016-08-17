//
//  MainMacro.h
//  ZTESoftProject
//
//  Created by YYang on 16/2/7.
//  Copyright © 2016年 YYang. All rights reserved.
//

#ifndef MainMacro_h
#define MainMacro_h


#ifndef __OPTIMIZE__
//这里执行的是debug模式下
#else
//这里执行的是release模式下
#endif

#if defined (__i386__) || defined (__x86_64__)
//模拟器下执行
#else
//真机下执行
#endif

#pragma mark - log 管理
#ifdef DEBUG
static const int ddLogLevel = DDLogLevelVerbose;
#else
static const int ddLogLevel = 0;
#endif

#ifdef DEBUG
#define NSLog(...) NSLog(__VA_ARGS__)
#define debugMethod() NSLog(@"%s", __func__)
#else
#define NSLog(...)
#define debugMethod()
#endif

#pragma mark - 设备宽高
//当前应用程序的bounds
#define kAppBounds [[UIScreen mainScreen] bounds]
//顶部导航控制器高度
#define kNavigationBarHeight self.navigationController.navigationBar.frame.size.height
//顶部状态栏高度
#define kTopStatusViewHeight 20
//NavBar高度
#define NavigationBar_HEIGHT 44
#define NavigationBarHeight (self.navigationController.navigationBar.frame.size.height + 20)
//顶部TabBar的高度
#define TabBarHegith self.tabBarController.tabBar.frame.size.height
//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#pragma mark - 颜色相关
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#pragma mark - 图片相关
//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]
//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

#pragma mark - 字体相关
#define kFont_10 [UIFont systemFontOfSize: 10]
#define kFont_12 [UIFont systemFontOfSize: 12]
#define kFont_13 [UIFont systemFontOfSize: 13]
#define kFont_14 [UIFont systemFontOfSize: 14]
#define kFont_15 [UIFont systemFontOfSize: 15]
#define kFont_17 [UIFont systemFontOfSize: 17]
#define kFont_20 [UIFont systemFontOfSize: 20]

#pragma mark - ToastPostion
#define kToastTop @"top"//顶部
#define kToastBottom @"bottom" //底部
#define kToastCenter @"center"//中部

#endif /* MainMacro_h */
