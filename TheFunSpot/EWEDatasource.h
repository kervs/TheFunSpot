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
@property (nonatomic, readonly) CLLocation *currentCoord;
@property (nonatomic,strong,readonly)MKMapItem *mapPoint;
@property (nonatomic, strong,readonly)EWECategory *selectedCat;
- (EWECategory *) addNewCategory:(NSString *)name andColor:(UIColor *)color;
- (EWESpot *) addSpotName:(NSString *)name addSpotnote:(NSString *)note andLocation:(CLLocationCoordinate2D)location andCategory:(EWECategory *)category;
- (void) delCategory:(EWECategory *)category;
- (void) newMapPoint:(MKMapItem *)mapPoint;
- (void) addNewCatForSpot: (EWECategory *)category;
@end
