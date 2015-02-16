//
//  ContainerViewController.m
//  TopLayoutTest
//
//  Created by Daniel Langh on 12/02/15.
//  Copyright (c) 2015 rumori. All rights reserved.
//

#import "RMContainerController.h"

#import "UIViewController+RMLayoutAdditions.h"

@interface RMContainerController ()

@property (nonatomic, retain) UIView *topBar;
@property (nonatomic, retain) UIView *bottomBar;

@end

#pragma mark -

@implementation RMContainerController

- (instancetype)initWithChildViewController:(UIViewController *)childViewController
{
    self = [super init];
    if(self)
    {
        self.childViewController = childViewController;
    }
    return self;
}

- (void)loadView
{
    UIView *v = [[UIView alloc] initWithFrame:CGRectZero];
    v.backgroundColor = [UIColor redColor];
    self.view = v;
    
    UIView *topBar = [[UIView alloc] initWithFrame:CGRectZero];
    topBar.backgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:0.5];
    topBar.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:topBar];
    self.topBar = topBar;

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:topBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f]];
    [topBar addConstraint:[NSLayoutConstraint constraintWithItem:topBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:44.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:topBar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:topBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(self.childViewController)
    {
        // sequence based on Apple's uiviewcontroller containment guide
        
        UIViewController *viewController = self.childViewController;
        
        [self addChildViewController:viewController];                 // 1
        UIView *view = self.childViewController.view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view insertSubview:view belowSubview:self.topBar];        // 2
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0]];
        
        [viewController didMoveToParentViewController:self];          // 3
    }
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
    if(self.childViewController)
    {
        // we have to add the new constraints to our view,
        // since it references the topbar which is further up the view hierarchy
        [self.childViewController removeTopLayoutConstraintsFromView:self.view];
        [self.view addConstraints:[self.childViewController createTopLayoutConstraintsWithItem:self.topBar attribute:NSLayoutAttributeBottom]];
        
        // example for constraints without bars, using the container viewcontrollers bottomLayoutGuide
        [self.childViewController removeBottomLayoutConstraintsFromView:self.view];
        [self.view addConstraints:[self.childViewController createBottomLayoutConstraintsWithItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop]];
    }
    
}

@end
