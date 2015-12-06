//
//  AppDelegate.m
//  HackerNewz
//
//  Created by Skye on 6/24/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HAppDelegate.h"

// View Controller
#import "HHomeViewController.h"

// Categories
#import "HNAdditions.h"
#import "SFAdditions.h"

@interface HAppDelegate ()
@property (nonatomic) UINavigationController *navController;
@end

@implementation HAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [[UILabel appearance] setSubstituteFont:[UIFont hnFont:0]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:[[HHomeViewController alloc] init]];
    self.navController.navigationBar.translucent = NO;
    self.navController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor],
                                                             NSFontAttributeName:[UIFont hnFont:20.0f]};
    
    self.navController.navigationBar.tintColor = [UIColor whiteColor];
    self.navController.navigationBar.barTintColor = [UIColor HNOrange];
    self.navController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self.navController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navController.navigationBar setShadowImage:[UIImage new]];
    
    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end
