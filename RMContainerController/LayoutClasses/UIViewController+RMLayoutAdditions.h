//
//  UIView+RMAdditions.h
//  TopLayoutTest
//
//  Created by Daniel Langh on 12/02/15.
//  Copyright (c) 2015 rumori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIViewController (RMLayoutAdditions)

- (NSArray *)removeTopLayoutConstraintsFromView:(UIView *)view;
- (NSArray *)createTopLayoutConstraintsWithItem:(id)item attribute:(NSLayoutAttribute)attribute;
- (NSArray *)topLayoutConstraints;

- (NSArray *)removeBottomLayoutConstraintsFromView:(UIView *)view;
- (NSArray *)createBottomLayoutConstraintsWithItem:(id)item attribute:(NSLayoutAttribute)attribute;
- (NSArray *)bottomLayoutConstraints;

@end
