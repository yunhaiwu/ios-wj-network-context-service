//
//  ViewController.m
//  WJNetworkContextService-example
//
//  Created by ada on 2019/3/6.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import "ViewController.h"
#import "WJAppContext.h"
#import "WJNetworkContextService.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    dispatch_async(dispatch_get_main_queue(), ^{
        id<WJNetContextService> service = [[WJApplicationContext sharedInstance] createService:@protocol(WJNetContextService)];
        NSLog(@"%li", [service currentNetStatus]);
    });
}


@end
