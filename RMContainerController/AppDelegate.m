//
//  AppDelegate.m
//  RMContainerController
//
//  Created by Daniel Langh on 16/02/15.
//  Copyright (c) 2015 rumori. All rights reserved.
//

#import "AppDelegate.h"

#import "RMContainerController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    UIViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateInitialViewController];
    RMContainerController *containerViewController = [[RMContainerController alloc] initWithChildViewController:viewController];
    containerViewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Toggle Bottom" style:UIBarButtonItemStylePlain target:self action:@selector(toggleBottomBar:)];
    
    UINavigationController *nvc = [[UINavigationController alloc] initWithRootViewController:containerViewController];
    nvc.toolbarHidden = NO;
    self.window.rootViewController = nvc;
    
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)toggleBottomBar:(id)sender
{
    UINavigationController *navigationController = (UINavigationController *)self.window.rootViewController;
    BOOL toolbarHidden = navigationController.toolbarHidden;
    [navigationController setToolbarHidden:!toolbarHidden animated:YES];
}

@end
