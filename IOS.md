### [官方文档](https://www.csjplatform.com/union/media/union/download/detail?id=81&osType=ios)

1、配置pod
在ios/Podfile文件中配置
```
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/bytedance/cocoapods_sdk_source_repo.git'
source 'https://github.com/volcengine/volcengine-specs.git'
```
```
target 'Runner' do
    pod 'Pangrowth', '1.7.0.0', :subspecs => [ 'novel' ]
end
```

2、把下载的json文件改名pangrowthconfig.json导入项目ios目录下

3、AppDelegate修改

OC修改ios/Runner/AppDelegate.m文件
```
#import "AppDelegate.h"
#import "GeneratedPluginRegistrant.h"

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

```

swift修改ios/Runner/AppDelegate.swift文件

```
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
}
```
