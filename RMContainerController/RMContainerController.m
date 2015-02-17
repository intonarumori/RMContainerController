//
//  ContainerViewController.m
//  TopLayoutTest
//
//  Created by Daniel Langh on 12/02/15.
//  Copyright (c) 2015 rumori. All rights reserved.
//

#import "RMContainerController.h"

#import "UIViewController+RMLayoutAdditions.h"

#define kTopBarTallHeight 100.0f
#define kTopBarShortHeight 30.0f

@interface RMContainerController ()

@property (nonatomic, retain) UIView *topBar;
@property (nonatomic, retain) UIView *bottomBar;

@property (nonatomic, retain) NSLayoutConstraint *topbarHeightConstraint;

@end

#pragma mark -

@implementation RMContainerController

- (instancetype)initWithChildViewController:(UIViewController *)childViewController
{
    self = [super init];
    if(self)
    {
        self.childViewController = childViewController;
        
        // important to set this, so navigationcontrollers don't
        // mess with our childviewcontroller's scrollviews
        self.automaticallyAdjustsScrollViewInsets = NO;
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
    [topBar setTag:111];
    self.topBar = topBar;

    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:topBar attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f]];
    self.topbarHeightConstraint = [NSLayoutConstraint constraintWithItem:topBar attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:kTopBarTallHeight];
    [topBar addConstraint:self.topbarHeightConstraint];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:topBar attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:topBar attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topLayoutGuide attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f]];
    
    UIButton *button  = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Toggle" forState:UIControlStateNormal];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    [self.topBar addSubview:button];
    
    [self.topBar addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.topBar attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0f]];
    [self.topBar addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.topBar attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0f]];
    [self.topBar addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.topBar attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0f]];
    [self.topBar addConstraint:[NSLayoutConstraint constraintWithItem:button attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topBar attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f]];
    
    [button addTarget:self action:@selector(toggleBar:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Toggle Bottom" style:UIBarButtonItemStylePlain target:self action:@selector(toggleBottomBar:)];

    
    
    
    
    if(self.childViewController)
    {
        // sequence based on Apple's uiviewcontroller containment guide
        
        UIViewController *viewController = self.childViewController;
        
        [self addChildViewController:viewController];                 // 1
        UIView *view = self.childViewController.view;
        view.translatesAutoresizingMaskIntoConstraints = NO;
        [self.view insertSubview:view belowSubview:self.topBar];        // 2

        // we have to add the new constraints to our view,
        // since it references the topbar which is further up the view hierarchy
        [self.childViewController removeTopLayoutConstraintsFromView:self.view];
        [self.view addConstraints:[self.childViewController createTopLayoutConstraintsWithItem:self.topBar attribute:NSLayoutAttributeBottom]];
        
        // example for constraints without bars, using the container viewcontrollers bottomLayoutGuide
        [self.childViewController removeBottomLayoutConstraintsFromView:self.view];
        [self.view addConstraints:[self.childViewController createBottomLayoutConstraintsWithItem:self.bottomLayoutGuide attribute:NSLayoutAttributeTop]];

        [viewController didMoveToParentViewController:self];          // 3
        
        
        
        ///////////////
        
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:1.0f constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeHeight multiplier:1.0f constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0]];
        [self.view addConstraint:[NSLayoutConstraint constraintWithItem:view attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeading multiplier:1.0f constant:0.0]];
    }
}

#pragma mark -

// TODO: remove this
- (void)toggleBottomBar:(id)sender
{
    BOOL hidden = self.navigationController.toolbarHidden;
    [self.navigationController setToolbarHidden:!hidden animated:YES];
}

#pragma mark -

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    ///NSLog(@"container viewDidLayoutSubviews %@", NSStringFromCGRect(self.topBar.frame));
}

- (void)updateViewConstraints
{
    [super updateViewConstraints];
    
//    NSLog(@"container updateViewConstraints %@", NSStringFromCGRect(self.topBar.frame));
}

- (CGFloat)topLayoutLength
{
    return [self.topLayoutGuide length] + kTopBarTallHeight;
}

#pragma mark -

- (void)toggleBar:(id)sender
{
    BOOL isTall = self.topbarHeightConstraint.constant == kTopBarTallHeight;
    self.topbarHeightConstraint.constant = isTall ? kTopBarShortHeight : kTopBarTallHeight;
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

@end
