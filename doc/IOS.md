### 一、[官方文档](https://www.csjplatform.com/union/media/union/download/detail?id=81&osType=ios)

### 二、插件配置
1、配置pod
在ios/Podfile文件中配置
```
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/bytedance/cocoapods_sdk_source_repo.git'
source 'https://github.com/volcengine/volcengine-specs.git'
```

> 插件升级尽量clean缓存，到ios目录下执行pod update避免不必要的类库找不到异常

2、把下载的json文件改名pangrowthconfig.json导入项目ios目录下

3、AppDelegate修改

OC修改ios/Runner/AppDelegate.m文件
```
#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"
#import <LCDSDK/LCDSDK.h>

@interface AppDelegate()
  @property (nonatomic, strong) UINavigationController *navigationController;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
    //将FlutterView设为根视图 嵌入导航
    FlutterViewController *controller = (FlutterViewController*)self.window.rootViewController;
    self.navigationController = [[UINavigationController alloc] initWithRootViewController:controller];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = self.navigationController;
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.window makeKeyAndVisible];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}
@end

// 为了视频的播放体验，必须在AppDelegate的applicationDidBecomeActive：和applicationWillResignActive：
//中调用开始渲染和停止渲染方法(这两个方法不耗时)。不做这一步可能带来未知的黑屏或者crash。
- (void)applicationWillResignActive:(UIApplication *)application {
     // ⚠️⚠️⚠️⚠️⚠️ 重点关注
    [LCDManager stopOpenGLESActivity];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   // ⚠️⚠️⚠️⚠️⚠️ 重点关注
    [LCDManager startOpenGLESActivity];
}

```

swift修改ios/Runner/AppDelegate.swift文件

```
import LCDSDK

@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
      var controller : FlutterViewController = window.rootViewController as! FlutterViewController
      var navigationController = UINavigationController.init(rootViewController: controller)
      window = UIWindow.init(frame: UIScreen.main.bounds)
      window.rootViewController = navigationController
      navigationController.setNavigationBarHidden(true, animated: true)
      window.makeKeyAndVisible()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
   // 为了视频的播放体验，必须在AppDelegate的applicationDidBecomeActive：和applicationWillResignActive：
    //中调用开始渲染和停止渲染方法(这两个方法不耗时)。不做这一步可能带来未知的黑屏或者crash。
    override func applicationWillResignActive(_ application: UIApplication) {
        LCDManager.stopOpenGLESActivity()
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        LCDManager.startOpenGLESActivity()
    }
}

```