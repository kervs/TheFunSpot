//
//  EWESpot.h
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/10/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//
#import <MapKit/MapKit.h>
#import <Foundation/Foundation.h>
#import "EWECategory.h"

@interface EWESpot : NSObject<NSCoding>

@property (nonatomic,weak) EWECategory *category;
@property (nonatomic,strong) NSString *categoryID;
@property (nonatomic,assign) CLLocationCoordinate2D location;
@property (nonatomic,strong) NSString *spotName;
@property (nonatomic,strong) NSString *note;
@property (nonatomic,assign) BOOL visited;

- (instancetype)initWithSpotName:(NSString *)name spotNote:(NSString *)note andLocation:(CLLocationCoordinate2D) location;


@end
