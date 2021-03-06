//
//  CommonHeader.h
//  ZXProject
//
//  Created by Mr.X on 2016/11/17.
//  Copyright © 2016年 Mr.X. All rights reserved.
//

#ifndef CommonHeader_h
#define CommonHeader_h

/********************系统工具引用*********************/
#import <Foundation/Foundation.h> //框架
#import <UIKit/UIKit.h> //UI

/********************自己工具引用*********************/
#import "GlobalURL.h" //网络地址
#import "NSDate+CH.h"   //日期
#import "UIButton+Response.h" //按钮点击间隔
#import "UIButton+Extension.h" //按钮扩展
#import "UIResponder+FirstResponder.h"  //第一响应
#import "UIView+Common.h" //坐标
#import "ZXTools.h"  //赵昕的工具
#import "NetworkHelper.h" //网络请求

/********************第三方引用*********************/
#import <AFNetworking.h> //网络请求
#import <JSONModel.h> //模型
#import <MBProgressHUD.h> //提示框
#import <MJRefresh.h> //刷新
#import <SDCycleScrollView.h> //轮播器
#import <UIImageView+WebCache.h>//sdWebImage
#import <TOWebViewController.h> // 跳转webView
#import <ZYQAssetPickerController.h> //添加图片
#import <IQKeyboardManager.h> //键盘弹出
#import <IQKeyboardReturnKeyHandler.h> //键盘弹出
#import <UIScrollView+EmptyDataSet.h> //tableView为空时数据为空


/**
 *  屏幕宽高比例（以6为基准）
 */
#define WIDTH_NIT   [[UIScreen mainScreen] bounds].size.width / 375
#define HEIGHT_NIT  [[UIScreen mainScreen] bounds].size.height / 667

/**
 *	RGB颜色
 */
 
#define RGBColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]

/**
 *	HexString颜色
 */
#define HexStringColor(hex) [UIColor colorWithHexString:(hex)]

/**
 *  获取当前设备
 */
#define kScreen_Height [UIScreen mainScreen].bounds.size.height

#define kScreen_Width [UIScreen mainScreen].bounds.size.width

#define kScreen_StatusBarHeight 20

#define kScreen_NavHeight 64

#define kScreen_tabBarHeight 49

#define kKeyWindow [UIApplication sharedApplication].keyWindow

#define kScreen_Bounds [UIScreen mainScreen].bounds

#define kDevice_Is_iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

#define kDevice_Is_iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define kDevice_Is_iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define kDevice_Is_iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define kDevice_Is_iPad ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(768, 1024), [[UIScreen mainScreen] currentMode].size) : NO)

#define kDevice_Is_iPad3 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1536, 2048), [[UIScreen mainScreen] currentMode].size) : NO)


/**
 *  weak strong self for retain cycle
 */
#define WEAK_SELF __weak typeof(self) weakSelf = self
#define STRONG_SELF __strong typeof(weakSelf) self = weakSelf


/**
 *  单例
 */
#define XLSingletonM(name) \
static id _instance = nil; \
+ (id)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (instancetype)shared##name \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

/**
 *  运行时间
 */
#define TICK   NSDate *startTime = [NSDate date]
#define TOCK   NSLog(@"Time: %f", -[startTime timeIntervalSinceNow])

/**
 *  重要颜色
 */

#define OneColor   RGBColor(40, 205, 251, 1)
#define TwoColor   RGBColor(40, 205, 251, 1)
#define ThreeColor RGBColor(40, 205, 251, 1)
#define BGColor    RGBColor(241, 241, 241, 1)
/**
 *  nav字体大小
 */
#define KNavigationFont [UIFont systemFontOfSize:18]
/**
 *  nav字体大小
 */
#define OneFont   [UIFont systemFontOfSize:18]
#define TwoFont   [UIFont systemFontOfSize:18]
#define ThreeFont [UIFont systemFontOfSize:18]
#define FourFont  [UIFont systemFontOfSize:18]

#endif /* CommonHeader_h */
