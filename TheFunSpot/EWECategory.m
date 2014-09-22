//
//  EWECategory.m
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/10/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "EWECategory.h"
#import "NSString+StringUtilities.h"

@interface EWECategory ()

@property (nonatomic, strong) NSString *identifier;

@end

@implementation EWECategory

- (instancetype)initWithName:(NSString *)name andColor:(UIColor *)color {
    self = [super init];
    if (self) {
        self.name = name;
        self.color = color;
        // generate random ID
        NSUInteger wordCount = arc4random_uniform(20);
        
        NSMutableString *randomSentence = [[NSMutableString alloc] init];
        
        for (int i  = 0; i <= wordCount; i++) {
            NSString *randomWord = [NSString randomStringOfLength:arc4random_uniform(12)];
            [randomSentence appendFormat:@"%@ ", randomWord];
        }
        self.identifier = randomSentence;

    }
    return self;
}

- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        self.identifier = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(identifier))];
        self.name = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(name))];
        self.color = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(color))];
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.identifier forKey:NSStringFromSelector(@selector(identifier))];
    [aCoder encodeObject:self.name forKey:NSStringFromSelector(@selector(name))];
    [aCoder encodeObject:self.color forKey:NSStringFromSelector(@selector(color))];
    }

@end
