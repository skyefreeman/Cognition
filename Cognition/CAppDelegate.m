//
//  AppDelegate.m
//  Cognition
//
//  Created by Skye on 6/24/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "CAppDelegate.h"
#import "CStoryViewController.h"
#import "CAdditions.h"
#import <Realm.h>

@interface CAppDelegate ()
@property (nonatomic, strong) UINavigationController *navController;
@end

@implementation CAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // Realm
    [self performRealmMigrationIfNeeded];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // I forgot what this is for
    [[UILabel appearance] setSubstituteFont:[UIFont CFont:0]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    
    self.navController = [[UINavigationController alloc] initWithRootViewController:[[CStoryViewController alloc] init]];
    self.navController.navigationBar.translucent = YES;
    self.navController.navigationBar.tintColor = [UIColor whiteColor];
    self.navController.navigationBar.barStyle = UIBarStyleBlack;

    self.window.rootViewController = self.navController;
    [self.window makeKeyAndVisible];
    
    return YES;
}

#pragma mark - Realm Migrations
- (void)performRealmMigrationIfNeeded {
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    config.schemaVersion = 3;
    
    config.migrationBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
    };
    
    [RLMRealmConfiguration setDefaultConfiguration:config];
    [RLMRealm defaultRealm];
}

@end
