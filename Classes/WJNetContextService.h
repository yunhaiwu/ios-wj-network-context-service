//
//  WJNetworkContext.h
//
//   __      __   _____
//  /\ \  __/\ \ /\___ \
//  \ \ \/\ \ \ \\/__/\ \
//   \ \ \ \ \ \ \  _\ \ \
//    \ \ \_/ \_\ \/\ \_\ \
//     \ `\___x___/\ \____/
//      '\/__//__/  \/___/
//
//  Created by 吴云海
//  Copyright (c) 2015年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 网络状态
 - WJNetworkStatusUnknown: 未知状态
 - WJNetworkStatusNotReachable: 无网络
 - WJNetworkStatusReachableViaWWAN: 3G/4G
 - WJNetworkStatusReachableViaWiFi: wifi
 */
typedef NS_ENUM(NSInteger, WJNetworkStatus) {
    WJNetworkStatusUnknown          = -1,
    WJNetworkStatusNotReachable     = 0,
    WJNetworkStatusReachableViaWWAN = 1,
    WJNetworkStatusReachableViaWiFi = 2,
};


/**
 网络环境服务接口
 */
@protocol WJNetContextService <NSObject>

/**
 启动状态栏网络访问标识
 */
- (void)startNetworkActivity;

/**
 停止状态栏网络访问标识
 */
- (void)stopNetworkActivity;

/**
 停止状态栏网络访问标识
 */
- (void)stopAllNetworkActivity;

/**
 网络是否已连接
 */
- (BOOL)hasNetConnected;

/**
 当前网络状态
 */
- (WJNetworkStatus)currentNetStatus;

/**
 添加网络通知
 */
- (void)addNotification:(id)target selector:(SEL)selector;

/**
 移除网络通知
 */
- (void)removeNotification:(id)target;

@end
