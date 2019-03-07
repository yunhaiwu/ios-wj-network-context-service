# WJNetworkContextService

http 请求组件api

### CocoaPods 安装

```
在Podfile 文件头部添加：
source：https://github.com/yunhaiwu/ios-wj-framework-cocoapods-specs.git

//网络环境服务API
pod WJNetworkContextService

```

### 要求
* ARC支持
* iOS 6.0+


### 使用方法

```
id<WJNetContextService> service = [[WJApplicationContext sharedInstance] createService:@protocol(WJNetContextService)];
WJNetworkStatus status = [service currentNetStatus];

```
