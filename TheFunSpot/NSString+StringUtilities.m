//
//  NSString+StringUtilities.m
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/19/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "NSString+StringUtilities.h"

@implementation NSString (StringUtilities)

+ (NSString *) randomStringOfLength:(NSUInteger)len {
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
    
    NSMutableString *s = [NSMutableString string];
    for (NSUInteger i = 0U; i < len; i++) {
        u_int32_t r = arc4random_uniform((u_int32_t)[alphabet length]);
        unichar c = [alphabet characterAtIndex:r];
        [s appendFormat:@"%C", c];
    }
    return [NSString stringWithString:s];
}

@end
