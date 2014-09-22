//
//  EWECategory.h
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/10/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EWECategory : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong, readonly) NSString *identifier;

- (instancetype)initWithName:(NSString *)name andColor:(UIColor *)color;

@end
