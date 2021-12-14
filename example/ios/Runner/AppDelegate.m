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

@end
