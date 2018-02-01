//
//  AppDelegate.m
//  test
//
//  Created by 何静 on 17/3/22.
//  Copyright © 2017年 何静. All rights reserved.
//

#import "AppDelegate.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif

#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IOS6_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    self.window.backgroundColor = [UIColor whiteColor];
    if (IOS10_OR_LATER) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert) completionHandler:^(BOOL granted, NSError * _Nullable error) {}];
    } else if (IOS8_OR_LATER){
        //iOS 8 - iOS 10系统
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound categories:nil];
        [application registerUserNotificationSettings:settings];
    } else {
        //iOS 8.0系统以下
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound];
    }
    [application registerForRemoteNotifications];
    [self creatLocalizedUserNotification];
    return YES;
}
//获取DeviceToken成功
-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
  
}
//获取DeviceToken失败
-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    
}
#pragma mark - iOS10 收到通知（本地和远端） UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    // 需要执行这个方法，选择是否提醒用户，有Badge、Sound、Alert三种类型可以设置
//    completionHandler(UNNotificationPresentationOptionBadge|
//                      UNNotificationPresentationOptionSound|
//                      UNNotificationPresentationOptionAlert);
    
    
}

#pragma mark -iOS 10之前收到通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"iOS7及以上系统，收到通知:%@", userInfo);
    completionHandler(UIBackgroundFetchResultNewData);
    //此处省略一万行需求代码。。。。。。
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    NSLog(@"iOS6及以下系统，收到通知:%@", userInfo);
    //此处省略一万行需求代码。。。。。。
}

-(void)creatLocalizedUserNotification {
    //设置触发条件
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:10.0f repeats:NO];
    UNMutableNotificationContent *content = [UNMutableNotificationContent new];
    content.title = @"title1";
    content.subtitle = @"subtitle";
    content.body = @"body";
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = @{@"key1":@"value1",@"key2":@"value2"};
    content.categoryIdentifier = @"Dely_locationCategory";
    //创建通知标示
    NSString *requestIdentifier = @"Dely.X.time";
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:timeTrigger];
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        if (!error) {
            NSLog(@"推送已添加成功 %@", requestIdentifier);
        } else {
            NSLog(@"推送添加失败%@",[error description]);
        }
    }];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
