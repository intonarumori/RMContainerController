//
//  AppDelegate.m
//  RMContainerController
//
//  Created by Daniel Langh on 16/02/15.
//  Copyright (c) 2015 rumori. All rights reserved.
//

#import "AppDelegate.h"

#import "RMContainerController.h"
#import "RMTableContentViewController.h"
#import "RMTableViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    self.window.rootViewController = [self setup3];

    [self.window makeKeyAndVisible];

    return YES;
}

- (UIViewController *)setup1
{
    UIViewController *tableViewController = [RMTableViewController new];
    
    RMContainerController *containerViewController = [[RMContainerController alloc] initWithChildViewController:tableViewController];
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:containerViewController];
    nvc.toolbarHidden = NO;

    return nvc;
}

- (UIViewController *)setup2
{
    UIViewController *tableViewController = [RMTableViewController new];

    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:tableViewController];
    nvc.toolbarHidden = NO;
    
    return nvc;
}

- (UIViewController *)setup3
{
    UIViewController *tableViewController = [RMTableViewController new];
    RMContainerController *containerViewController1 = [[RMContainerController alloc] initWithChildViewController:tableViewController];
    containerViewController1.title = @"1";
    UINavigationController *nvc1 = [[UINavigationController alloc] initWithRootViewController:containerViewController1];

    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    RMContainerController *containerViewController2 = [[RMContainerController alloc] initWithChildViewController:viewController];
    containerViewController2.title = @"2";
    UINavigationController *nvc2 = [[UINavigationController alloc] initWithRootViewController:containerViewController2];

    UITabBarController *tabbarController = [[UITabBarController alloc] init];
    tabbarController.viewControllers = @[nvc1, nvc2];
    
    return tabbarController;
}

@end
