//
//  RMTableViewController.m
//  RMContainerController
//
//  Created by Daniel Langh on 17/02/15.
//  Copyright (c) 2015 rumori. All rights reserved.
//

#import "RMTableViewController.h"

#import "UIViewController+RMLayoutAdditions.h"

@interface RMTableViewController ()

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, assign) CGFloat offsetY;

@end

#pragma mark -

@implementation RMTableViewController

- (void)loadView
{
    CGRect frame = CGRectMake(0, 0, 300, 300);
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    self.view = view;
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableView = tableView;

    [self.view addSubview:tableView];
}

#pragma mark -

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    // where should we align
    CGFloat top = [self accumulatedTopLayoutLength];
    CGFloat bottom = [self accumulatedBottomLayoutLength];

    // get the current state of the scroll
    CGFloat contentOffsetTop = self.tableView.contentOffset.y;
    CGFloat contentInsetTop = self.tableView.contentInset.top;
    CGFloat deltaTop = contentInsetTop + contentOffsetTop;
    
    // setup the insets
    UIEdgeInsets insets = UIEdgeInsetsMake(top, 0, bottom, 0);
    self.tableView.contentInset = insets;
    self.tableView.scrollIndicatorInsets = insets;
    
    // adjust offset to match previous state
    self.tableView.contentOffset = CGPointMake(0, -top + deltaTop);
     
    //NSLog(@"table viewDidLayoutSubviews %f %f %f", top, contentOffsetTop, deltaTop);
}

#pragma mark -

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld", indexPath.section, indexPath.row];
    return cell;
}

@end
