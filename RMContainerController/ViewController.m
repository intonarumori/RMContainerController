//
//  ViewController.m
//  RMContainerController
//
//  Created by Daniel Langh on 16/02/15.
//  Copyright (c) 2015 rumori. All rights reserved.
//

#import "ViewController.h"

#import "UIViewController+RMLayoutAdditions.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

    //NSLayoutConstraint *constraint = [[self topLayoutConstraints] objectAtIndex:0];
    //NSLog(@"constraint %@", constraint);
}

@end
