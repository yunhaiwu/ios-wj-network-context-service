//
//  DefaultNetworkContextService.m
//  WJNetworkContextService-example
//
//  Created by ada on 2019/3/6.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "DefaultNetworkContextService.h"
#import <AFNetworking/AFNetworkReachabilityManager.h>

@interface DefaultNetworkContextService ()

@property (nonatomic, strong) dispatch_semaphore_t semaphore;

@property (nonatomic, strong) AFNetworkReachabilityManager *networkReachabilityManager;

@property (nonatomic, assign) int counter;

@end

@implementation DefaultNetworkContextService

+ (BOOL)hasSingleton {
    return YES;
}

- (id)copy {
    return self;
}

- (id)mutableCopy {
    return self;
}

+ (instancetype)sharedInstance {
    static dispatch_once_t once;
    static DefaultNetworkContextService *singletonInstance;
    dispatch_once( &once, ^{
        singletonInstance = [[self alloc] init];
        [singletonInstance singleInit];
    });
    return singletonInstance;
}

- (void)singleInit {
    self.semaphore = dispatch_semaphore_create(1);
    self.networkReachabilityManager = [AFNetworkReachabilityManager sharedManager];
    [self.networkReachabilityManager startMonitoring];
}

- (void)startNetworkActivity {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    if (_counter == 0) {
        if ([[NSThread currentThread] isMainThread]) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
            });
        }
    }
    _counter++;
    dispatch_semaphore_signal(self.semaphore);
}

- (void)stopNetworkActivity {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    if (_counter > 0 && --_counter == 0) {
        if ([[NSThread currentThread] isMainThread]) {
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
            });
        }
    }
    dispatch_semaphore_signal(self.semaphore);
}

- (void)stopAllNetworkActivity {
    dispatch_semaphore_wait(self.semaphore, DISPATCH_TIME_FOREVER);
    _counter = 0;
    if ([[NSThread currentThread] isMainThread]) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        });
    }
    dispatch_semaphore_signal(self.semaphore);
}

- (BOOL)hasNetConnected {
    return [[AFNetworkReachabilityManager manager] isReachable];
}

- (WJNetworkStatus)currentNetStatus {
    WJNetworkStatus status;
    AFNetworkReachabilityStatus s = [self.networkReachabilityManager networkReachabilityStatus];
    switch (s) {
        case AFNetworkReachabilityStatusReachableViaWiFi:
            status = WJNetworkStatusReachableViaWiFi;
            break;
        case AFNetworkReachabilityStatusReachableViaWWAN:
            status = WJNetworkStatusReachableViaWWAN;
            break;
        case AFNetworkReachabilityStatusNotReachable:
            status = WJNetworkStatusNotReachable;
            break;
        default:
            status = WJNetworkStatusUnknown;
            break;
    }
    return status;
}

- (void)addNotification:(id)target selector:(SEL)selector {
    if ([target respondsToSelector:selector]) {
        [[NSNotificationCenter defaultCenter] addObserver:target selector:selector name:AFNetworkingReachabilityDidChangeNotification object:nil];
    }
}

- (void)removeNotification:(id)target {
    [[NSNotificationCenter defaultCenter] removeObserver:target name:AFNetworkingReachabilityDidChangeNotification object:nil];
}


@end
