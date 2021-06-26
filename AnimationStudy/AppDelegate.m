//
//  AppDelegate.m
//  AnimationStudy
//
//  Created by mingxing on 2020/4/14.
//  Copyright © 2020 Star. All rights reserved.
//

#import "AppDelegate.h"
#import "MXTabBarViewController.h"
#import "MXNavigationViewController.h"
#import "MXQuartzCoreMainVC.h"
#import "MXSQLiteMainVC.h"
#import "XMDemoListVC.h"

#import "QMUIConfigurationTemplateGrapefruit.h"
#import "QMUIConfigurationTemplateGrass.h"
#import "QMUIConfigurationTemplatePinkRose.h"
#import "QMUIConfigurationTemplateDark.h"

//#import <QMUIKit.h>
//#import "InjectionIIIHelper.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 1. 先注册主题监听，在回调里将主题持久化存储，避免启动过程中主题发生变化时读取到错误的值
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleThemeDidChangeNotification:) name:QMUIThemeDidChangeNotification object:nil];

    QMUIThemeManagerCenter.defaultThemeManager.themeGenerator = ^__kindof NSObject * _Nullable(__kindof NSObject<NSCopying> * _Nonnull identifier) {
        if ([identifier isEqualToString:MXThemeIdentifierDefault]) return QMUIConfigurationTemplate.new;
        if ([identifier isEqualToString:MXThemeIdentifierGrapefruit]) return QMUIConfigurationTemplateGrapefruit.new;
        if ([identifier isEqualToString:MXThemeIdentifierGrass]) return QMUIConfigurationTemplateGrass.new;
        if ([identifier isEqualToString:MXThemeIdentifierPinkRose]) return QMUIConfigurationTemplatePinkRose.new;
        if ([identifier isEqualToString:MXThemeIdentifierDark]) return QMUIConfigurationTemplateDark.new;
        return nil;
    };
    
    // 3. 再针对 iOS 13 开启自动响应系统的 Dark Mode 切换
       // 如果不需要这个功能，则不需要这一段代码
       if (@available(iOS 13.0, *)) {
           // 做这个 if(currentThemeIdentifier) 的保护只是为了避免 QD 里的配置表没启动时，没人为 currentTheme/currentThemeIdentifier 赋值，导致后续的逻辑会 crash，业务项目里理论上不会有这种情况出现，所以可以省略这个 if 块
           if (QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier) {
               QMUIThemeManagerCenter.defaultThemeManager.identifierForTrait = ^__kindof NSObject<NSCopying> * _Nonnull(UITraitCollection * _Nonnull trait) {
                   if (trait.userInterfaceStyle == UIUserInterfaceStyleDark) {
                       return MXThemeIdentifierDark;
                   }
                   
                   if ([QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier isEqual:MXThemeIdentifierDark]) {
                       return MXThemeIdentifierDefault;
                   }
                   
                   return QMUIThemeManagerCenter.defaultThemeManager.currentThemeIdentifier;
               };
               QMUIThemeManagerCenter.defaultThemeManager.respondsSystemStyleAutomatically = YES;
           }
       }
    
    // QD自定义的全局样式渲染
    [MXCommonUI renderGlobalAppearances];
    
    [self didInitWindow];

    return YES;
}

- (void)didInitWindow {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [self generateWindowRootViewController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
}

- (UIViewController *)generateWindowRootViewController {
    MXTabBarViewController *tabbarVC = [[MXTabBarViewController alloc] init];
    
    MXQuartzCoreMainVC *quartzCore = [[MXQuartzCoreMainVC alloc] init];
    quartzCore.hidesBottomBarWhenPushed = NO;
    MXNavigationViewController *quartzCoreNav = [[MXNavigationViewController alloc] initWithRootViewController:quartzCore];
    quartzCoreNav.tabBarItem = [MXUIHelper tabBarItemWithTitle:@"QuartzCore" image:UIImageMake(@"icon_tabbar_uikit") selectedImage:UIImageMake(@"icon_tabbar_uikit_selected") tag:0];

    
    MXSQLiteMainVC *sqlVC = [[MXSQLiteMainVC alloc] init];
    sqlVC.hidesBottomBarWhenPushed = NO;
    MXNavigationViewController *sqlNav = [[MXNavigationViewController alloc] initWithRootViewController:sqlVC];
    sqlNav.tabBarItem = [MXUIHelper tabBarItemWithTitle:@"SQLine" image:UIImageMake(@"icon_tabbar_uikit") selectedImage:UIImageMake(@"icon_tabbar_uikit_selected") tag:1];
    
    XMDemoListVC *demoVC = [[XMDemoListVC alloc] init];
    demoVC.hidesBottomBarWhenPushed = NO;
    MXNavigationViewController *demoNav = [[MXNavigationViewController alloc] initWithRootViewController:demoVC];
    demoNav.tabBarItem = [MXUIHelper tabBarItemWithTitle:@"Demo" image:UIImageMake(@"icon_tabbar_uikit") selectedImage:UIImageMake(@"icon_tabbar_uikit_selected") tag:2];
    
    tabbarVC.viewControllers = @[quartzCoreNav,sqlNav,demoNav];
    
    return tabbarVC;
}

- (void)handleThemeDidChangeNotification:(NSNotification *)notification {
    
    QMUIThemeManager *manager = notification.object;
    if (![manager.name isEqual:QMUIThemeManagerNameDefault]) return;

    [[NSUserDefaults standardUserDefaults] setObject:manager.currentThemeIdentifier forKey:MXSelectedThemeIdentifier];

    [MXThemeManager.currentTheme applyConfigurationTemplate];

    // 主题发生变化，在这里更新全局 UI 控件的 appearance
    [MXCommonUI renderGlobalAppearances];

    // 更新表情 icon 的颜色
    [MXUIHelper updateEmotionImages];
}

#pragma mark - UISceneSession lifecycle


//- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
//    // Called when a new scene session is being created.
//    // Use this method to select a configuration to create the new scene with.
//    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
//}
//
//
//- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
//    // Called when the user discards a scene session.
//    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//}


@end
