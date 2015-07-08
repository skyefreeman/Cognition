//
//  AppDelegate.m
//  HackerNewz
//
//  Created by Skye on 6/24/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HAppDelegate.h"
#import "UIColor+HNAdditions.h"
#import "UILabel+HNAdditions.h"
#import "HMainViewController.h"

@interface HAppDelegate ()
@property (nonatomic) UINavigationController *navController;
@end

@implementation HAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [application setStatusBarHidden:YES];
    [[UILabel appearance] setSubstituteFontWithName:@"HelveticaNeue-Light"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    HMainViewController *vc = [[HMainViewController alloc] init];

    self.navController = [[UINavigationController alloc] initWithRootViewController:vc];
    self.navController.navigationBar.translucent = NO;
    self.navController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navController.navigationBar.barTintColor = [UIColor HNOrange];
    
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
