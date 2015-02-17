//
//  UIView+RMAdditions.m
//  TopLayoutTest
//
//  Created by Daniel Langh on 12/02/15.
//  Copyright (c) 2015 rumori. All rights reserved.
//

#import "UIViewController+RMLayoutAdditions.h"
#import <objc/runtime.h>

#import "NSLayoutConstraint+RMLayoutAdditions.h"

static const char kUIViewRMLayoutAdditionsTopLayoutConstraint;
static const char kUIViewRMLayoutAdditionsBottomLayoutConstraint;

@implementation UIViewController (RMLayoutAdditions)

#pragma mark -

- (CGFloat)accumulatedTopLayoutLength
{
    if([self conformsToProtocol:@protocol(RMCustomTopLayoutLengthProtocol)])
    {
        return [(id<RMCustomTopLayoutLengthProtocol>)self topLayoutLength];
    }
    else
    {
        NSArray *constraints = [self topLayoutConstraints];
        
        if(constraints.count > 0)
        {
            NSLayoutConstraint *topConstraint = [constraints firstObject];
            
            // TODO: we know it's the first since we set it up like that
            // BTW: the layoutGuide is UIview too
            UIView *v = (UIView *)topConstraint.secondItem;
            
            UIView *parent = [self rm_superviewNotWindow:v];

            // TODO: is this correct?
            CGRect rect = [v convertRect:v.bounds toView:parent];
            return CGRectGetMaxY(rect);
        }
        else
        {
            return [self.topLayoutGuide length];
        }
    }
}

- (CGFloat)accumulatedBottomLayoutLength
{
    if([self conformsToProtocol:@protocol(RMCustomBottomLayoutLengthProtocol)])
    {
        return [(id<RMCustomBottomLayoutLengthProtocol>)self bottomLayoutLength];
    }
    else
    {
        NSArray *constraints = [self bottomLayoutConstraints];
        
        if(constraints.count > 0)
        {
            NSLayoutConstraint *topConstraint = [constraints firstObject];
            
            // TODO: we know it's the first since we set it up like that
            // BTW: the layoutGuide is UIview too
            UIView *v = (UIView *)topConstraint.secondItem;
            
            // find super view that is not the window
            UIView *parent = [self rm_superviewNotWindow:v];

            // TODO: is this correct?
            CGRect rect = [v convertRect:v.bounds toView:parent];
            CGRect viewRect = [self.view convertRect:self.view.bounds toView:parent];
            CGFloat bottom = CGRectGetMaxY(viewRect) - rect.origin.y;

            return bottom;
        }
        else
        {
            return [self.topLayoutGuide length];
        }
    }
}

- (UIView *)rm_superviewNotWindow:(UIView *)view
{
    UIView *parent = view.superview;
    while (parent.superview && ![parent.superview isKindOfClass:[UIWindow class]]) {
        parent = parent.superview;
    }
    return parent;
}

- (NSArray *)topLayoutConstraints
{
    // access it so it is created
    id __unused layoutGuide = self.topLayoutGuide;
    
    return objc_getAssociatedObject(self, &kUIViewRMLayoutAdditionsTopLayoutConstraint);
}

- (NSArray *)createTopLayoutConstraintsWithItem:(id)item attribute:(NSLayoutAttribute)attribute
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.topLayoutGuide
                                                                  attribute:NSLayoutAttributeTop
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:item
                                                                  attribute:attribute
                                                                 multiplier:1.0f
                                                                   constant:0.0f];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.topLayoutGuide
                                                                  attribute:NSLayoutAttributeHeight
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:nil
                                                                  attribute:NSLayoutAttributeNotAnAttribute
                                                                 multiplier:1.0f
                                                                   constant:0.0f];
    NSArray *newConstraints = @[constraint, constraint2];
    objc_setAssociatedObject(self, &kUIViewRMLayoutAdditionsTopLayoutConstraint, newConstraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return newConstraints;
}

- (NSArray *)removeTopLayoutConstraintsFromView:(UIView *)view
{
    NSArray *topLayoutConstraints = [self topLayoutConstraints];
    if(topLayoutConstraints)
    {
        [view removeConstraints:topLayoutConstraints];
    }
    else
    {
        topLayoutConstraints = [self rm_defaultTopGuideConstraints];
        [self.view removeConstraints:topLayoutConstraints];
    }
    return topLayoutConstraints;
}

#pragma mark -

- (NSArray *)bottomLayoutConstraints
{
    // access it so it is created
    id __unused layoutGuide = self.bottomLayoutGuide;

    return objc_getAssociatedObject(self, &kUIViewRMLayoutAdditionsBottomLayoutConstraint);
}

- (NSArray *)removeBottomLayoutConstraintsFromView:(UIView *)view
{
    NSArray *topLayoutConstraints = [self bottomLayoutConstraints];
    if(topLayoutConstraints)
    {
        [view removeConstraints:topLayoutConstraints];
    }
    else
    {
        topLayoutConstraints = [self rm_defaultBottomGuideConstraints];
        [self.view removeConstraints:topLayoutConstraints];
    }
    return topLayoutConstraints;
}
- (NSArray *)createBottomLayoutConstraintsWithItem:(id)item attribute:(NSLayoutAttribute)attribute
{
    NSLayoutConstraint *constraint = [NSLayoutConstraint constraintWithItem:self.bottomLayoutGuide
                                                                  attribute:NSLayoutAttributeBottom
                                                                  relatedBy:NSLayoutRelationEqual
                                                                     toItem:item
                                                                  attribute:attribute
                                                                 multiplier:1.0f
                                                                   constant:0.0f];
    NSLayoutConstraint *constraint2 = [NSLayoutConstraint constraintWithItem:self.bottomLayoutGuide
                                                                   attribute:NSLayoutAttributeHeight
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:nil
                                                                   attribute:NSLayoutAttributeNotAnAttribute
                                                                  multiplier:1.0f
                                                                    constant:0.0f];
    NSArray *newConstraints = @[constraint, constraint2];
    objc_setAssociatedObject(self, &kUIViewRMLayoutAdditionsBottomLayoutConstraint, newConstraints, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    return newConstraints;
}

#pragma mark - helper

- (NSArray *)rm_defaultTopGuideConstraints
{
    NSArray *supportConstraints = [self rm_filterSupportConstraints:self.view.constraints];
    
    NSMutableArray *recordedTopLayoutConstraints = [NSMutableArray array];
    
    for(NSLayoutConstraint *constraint in supportConstraints)
    {
        if(constraint.firstItem == self.topLayoutGuide)
        {
            [recordedTopLayoutConstraints addObject:constraint];
        }
    }
    return recordedTopLayoutConstraints;
}

- (NSArray *)rm_defaultBottomGuideConstraints
{
    NSArray *supportConstraints = [self rm_filterSupportConstraints:self.view.constraints];
    NSMutableArray *recordedBottomLayoutConstraints = [NSMutableArray array];
    
    for(NSLayoutConstraint *constraint in supportConstraints)
    {
        if(constraint.firstItem == self.bottomLayoutGuide)
        {
            [recordedBottomLayoutConstraints addObject:constraint];
        }
    }
    return recordedBottomLayoutConstraints;
}

- (NSArray *)rm_filterSupportConstraints:(NSArray *)constraints
{
    NSMutableArray *supportConstraints = [NSMutableArray array];
    
    for(NSLayoutConstraint *constraint in constraints)
    {
        if(![constraint isMemberOfClass:[NSLayoutConstraint class]])
        {
            BOOL isLayoutGuide = [constraint.firstItem conformsToProtocol:@protocol(UILayoutSupport)];
            
            if(isLayoutGuide)
            {
                //id<UILayoutSupport> guide = (id<UILayoutSupport>)constraint.firstItem;
                [supportConstraints addObject:constraint];
            }
        }
    }
    return supportConstraints;
}

@end
