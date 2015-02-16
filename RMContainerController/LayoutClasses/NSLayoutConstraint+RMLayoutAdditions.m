//
//  NSLayoutConstraint+RMLayoutAdditions.m
//  TopLayoutTest
//
//  Created by Daniel Langh on 16/02/15.
//  Copyright (c) 2015 rumori. All rights reserved.
//

#import "NSLayoutConstraint+RMLayoutAdditions.h"

@implementation NSLayoutConstraint (RMLayoutAdditions)

#pragma mark - helper for debugging

+ (NSString *)layoutAttributeToString:(NSLayoutAttribute)attribute
{
    NSString *name = nil;
    switch (attribute) {
        case NSLayoutAttributeLastBaseline:
            name = @"NSLayoutAttributeLastline";
            break;
        case NSLayoutAttributeBottom:
            name = @"NSLayoutAttributeBottom";
            break;
        case NSLayoutAttributeBottomMargin:
            name = @"NSLayoutAttributeBottomMargin";
            break;
        case NSLayoutAttributeCenterX:
            name = @"NSLayoutAttributeCenterX";
            break;
        case NSLayoutAttributeCenterXWithinMargins:
            name = @"NSLayoutAttributeCenterXWithinMargins";
            break;
        case NSLayoutAttributeCenterY:
            name = @"NSLayoutAttributeCenterY";
            break;
        case NSLayoutAttributeCenterYWithinMargins:
            name = @"NSLayoutAttributeCenterYWithinMargins";
            break;
        case NSLayoutAttributeFirstBaseline:
            name = @"NSLayoutAttributeFirstBaseline";
            break;
        case NSLayoutAttributeHeight:
            name = @"NSLayoutAttributeHeight";
            break;
        case NSLayoutAttributeLeading:
            name = @"NSLayoutAttributeLeading";
            break;
        case NSLayoutAttributeLeadingMargin:
            name = @"NSLayoutAttributeLeadingMargin";
            break;
        case NSLayoutAttributeLeft:
            name = @"NSLayoutAttributeLeft";
            break;
        case NSLayoutAttributeLeftMargin:
            name = @"NSLayoutAttributeLeftMargin";
            break;
        case NSLayoutAttributeNotAnAttribute:
            name = @"NSLayoutAttributeNotAnAttribute";
            break;
        case NSLayoutAttributeRight:
            name = @"NSLayoutAttributeRight";
            break;
        case NSLayoutAttributeRightMargin:
            name = @"NSLayoutAttributeRightMargin";
            break;
        case NSLayoutAttributeTop:
            name = @"NSLayoutAttributeTop";
            break;
        case NSLayoutAttributeTopMargin:
            name = @"NSLayoutAttributeTopMargin";
            break;
        case NSLayoutAttributeTrailing:
            name = @"NSLayoutAttributeTrailing";
            break;
        case NSLayoutAttributeTrailingMargin:
            name = @"NSLayoutAttributeTrailingMargin";
            break;
        case NSLayoutAttributeWidth:
            name = @"NSLayoutAttributeWidth";
            break;
    }
    return name;
}

@end
