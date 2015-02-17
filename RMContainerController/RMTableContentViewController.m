//
//  RMTableContentViewController.m
//  RMContainerController
//
//  Created by Daniel Langh on 16/02/15.
//  Copyright (c) 2015 rumori. All rights reserved.
//

#import "RMTableContentViewController.h"
#import "UIViewController+RMLayoutAdditions.h"

@interface RMTableContentViewController ()

@property (nonatomic, assign) CGFloat offsetY;

@end

@implementation RMTableContentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor redColor];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _offsetY = self.tableView.contentOffset.y;
    
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    
    NSLog(@"TABLE %@ %@", NSStringFromCGRect(self.tableView.frame), NSStringFromCGSize(self.tableView.contentSize));
    
    /*

    CGFloat topOffset = _offsetY;
    CGFloat topInset = self.tableView.contentInset.top;

    CGFloat top = [self accumulatedTopLayoutLength];
    
    
    NSLog(@"table viewDidLayoutSubviews %f %f %f %d", top, topInset, topOffset, self.automaticallyAdjustsScrollViewInsets);
    
    //self.tableView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0);
    //self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(top, 0, 0, 0);
    
    //[self updateContentInsets];
    
    
    
    NSLog(@"-----------------");
    NSLog(@"view: %@", NSStringFromClass([self.tableView.superview.superview.superview.superview class]));
    NSLog(@"view: %@", NSStringFromClass([self.tableView.superview.superview.superview class]));
    NSLog(@"view: %@", NSStringFromClass([self.tableView.superview.superview class]));
    NSLog(@"view: %@", NSStringFromClass([self.tableView.superview class]));
    NSLog(@"view: %@", NSStringFromClass([self.tableView class]));
    */
}

- (void)updateContentInsets
{
    if(self.automaticallyAdjustsScrollViewInsets)
    {
        NSLayoutConstraint *constraint = [[self topLayoutConstraints] objectAtIndex:0];
        UIView *view = constraint.secondItem;
        
        CGRect rect = [view convertRect:view.bounds toView:nil];
        CGFloat top = CGRectGetMaxY(rect);
        NSLog(@"rect %f", top);
        
        self.tableView.contentInset = UIEdgeInsetsMake(top, 0, 0, 0);
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(top, 0, 0, 0);
    }
    else
    {
        self.tableView.contentInset = UIEdgeInsetsZero;
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsZero;
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = @"test";
    
    return cell;
}

@end
