//
//  DefaultNetworkContextService.h
//  WJNetworkContextService-example
//
//  Created by ada on 2019/3/6.
//  Copyright © 2019年 WJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WJNetContextService.h"
#import "WJAppContext.h"

@WJService(WJNetContextService, DefaultNetworkContextService)
@interface DefaultNetworkContextService : NSObject<WJNetContextService>

@end
