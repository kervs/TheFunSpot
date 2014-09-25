//
//  EWEDatasource.h
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/10/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EWESpot.h"

@interface EWEDatasource : NSObject

+(instancetype) sharedInstance;

@property (nonatomic,strong,readonly) NSArray *spotAdded;
@property (nonatomic,strong,readonly) NSArray *categories;

- (EWECategory *) addNewCategory:(NSString *)name andColor:(UIColor *)color;
- (EWESpot *) addSpotName:(NSString *)name addSpotnote:(NSString *)note andLocation:(CLLocationCoordinate2D)location;
- (void) delCategory:(EWECategory *)category;
@end
