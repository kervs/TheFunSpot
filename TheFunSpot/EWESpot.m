//
//  EWESpot.m
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/10/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "EWESpot.h"

@implementation EWESpot

- (instancetype)initWithSpotName:(NSString *)name spotNote:(NSString *)note andLocation:(CLLocationCoordinate2D) location andCategory:(EWECategory *)category {
    self = [super init];
    if (self) {
        self.spotName = name;
        self.note = note;
        self.location = location;
        self.visited = NO;
        self.category = category;
        
    }
    return self;
}
- (instancetype) initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    
    if (self) {
        self.categoryID = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(categoryID))];
        self.spotName = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(spotName))];
        self.note = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(note))];
        self.visited = [aDecoder decodeBoolForKey:NSStringFromSelector(@selector(visited))];
        CLLocationDegrees lat = [aDecoder decodeDoubleForKey:@"latitude"];
        CLLocationDegrees long1 = [aDecoder decodeDoubleForKey:@"longitude"];
        self.location = CLLocationCoordinate2DMake(lat, long1);
    }
    
    return self;
}

- (void) encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeDouble:self.location.latitude forKey:@"latitude"];
    [aCoder encodeDouble:self.location.longitude forKey:@"longitude"];
    [aCoder encodeObject:self.categoryID forKey:NSStringFromSelector(@selector(categoryID))];
    [aCoder encodeObject:self.spotName forKey:NSStringFromSelector(@selector(spotName))];
    [aCoder encodeObject:self.note forKey:NSStringFromSelector(@selector(categoryID))];
    [aCoder encodeBool:self.visited forKey:NSStringFromSelector(@selector(visited))];
}


@end
