//
//  UIView+RMAdditions.h
//  TopLayoutTest
//
//  Created by Daniel Langh on 12/02/15.
//  Copyright (c) 2015 rumori. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol RMCustomTopLayoutLengthProtocol <NSObject>

- (CGFloat)topLayoutLength;

@end

@protocol RMCustomBottomLayoutLengthProtocol <NSObject>

- (CGFloat)bottomLayoutLength;

@end

#pragma mark -

@interface UIViewController (RMLayoutAdditions)

- (NSArray *)removeTopLayoutConstraintsFromView:(UIView *)view;
- (NSArray *)createTopLayoutConstraintsWithItem:(id)item attribute:(NSLayoutAttribute)attribute;
- (NSArray *)topLayoutConstraints;

- (NSArray *)removeBottomLayoutConstraintsFromView:(UIView *)view;
- (NSArray *)createBottomLayoutConstraintsWithItem:(id)item attribute:(NSLayoutAttribute)attribute;
- (NSArray *)bottomLayoutConstraints;

- (NSArray *)rm_defaultTopGuideConstraints;
- (NSArray *)rm_defaultBottomGuideConstraints;

- (CGFloat)accumulatedTopLayoutLength;
- (CGFloat)accumulatedBottomLayoutLength;

@end
