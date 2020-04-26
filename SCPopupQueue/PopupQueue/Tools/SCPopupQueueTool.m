//
//  SCPopupQueueTool.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "SCPopupQueueTool.h"

@implementation SCPopupQueueTool

+ (UIViewController *)topViewController {
    return [self rootNavigationController].topViewController;
}

+ (UINavigationController *)rootNavigationController {
    UIViewController *rootViewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController *)rootViewController;
        UINavigationController *navigationController = (UINavigationController *)tabBarVC.selectedViewController;
        return navigationController;
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)rootViewController;
    } else {
        return rootViewController.navigationController;
    }
}

@end
