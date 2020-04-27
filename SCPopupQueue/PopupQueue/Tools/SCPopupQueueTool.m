//
//  SCPopupQueueTool.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "SCPopupQueueTool.h"

@implementation SCPopupQueueTool

+ (UINavigationController *)rootNavigationController {
    UIViewController *rootVC = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarVC = (UITabBarController *)rootVC;
        UINavigationController *navc = (UINavigationController *)tabBarVC.selectedViewController;
        return navc;
    } else if ([rootVC isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)rootVC;
    } else {
        return rootVC.navigationController;
    }
}

@end
