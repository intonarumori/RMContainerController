//
//  ContainerViewController.h
//  TopLayoutTest
//
//  Created by Daniel Langh on 12/02/15.
//  Copyright (c) 2015 rumori. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RMContainerController : UIViewController

@property (nonatomic, retain) UIViewController *childViewController;

- (instancetype)initWithChildViewController:(UIViewController *)childViewController;

@end
