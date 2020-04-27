//
//  AppDelegate.m
//  SCPopupQueue
//
//  Created by 妈妈网 on 2020/4/26.
//  Copyright © 2020 妈妈网. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    UINavigationController *navc = [[UINavigationController alloc] init];
    ViewController *vc = [[ViewController alloc] init];
    navc.viewControllers = @[vc];
    self.window.rootViewController = navc;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
