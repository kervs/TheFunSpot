//
//  EWEMapViewController.h
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/4/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface EWEMapViewController : UIViewController

@property (nonatomic, assign) CLLocationCoordinate2D newLocation;
@property (nonatomic, strong) NSArray *listOfLocation;

@end
