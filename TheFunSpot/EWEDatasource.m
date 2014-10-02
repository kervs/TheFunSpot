//
//  EWEDatasource.m
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/10/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "EWEDatasource.h"
#import "EWECategory.h"
#import "EWESpot.h"
#import <CoreLocation/CoreLocation.h>
#import "NSString+StringUtilities.h"


@interface EWEDatasource ()<CLLocationManagerDelegate>
@property (nonatomic, strong)NSArray *spotAdded;
@property (nonatomic, strong)NSArray *categories;
@property (nonatomic, assign)CLLocation *currentCoord;
@property (nonatomic, retain)CLLocationManager *locationManger;
@property (nonatomic,strong)MKMapItem *mapPoint;
@property (nonatomic, strong)EWECategory *selectedCat;
@end

@implementation EWEDatasource

// to have only one instance of this class
+(instancetype) sharedInstance {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
    
}

-(instancetype) init {
    self = [super init];
    if (self) {
        
        NSString *fullPath = [self pathForFilename:NSStringFromSelector(@selector(spotAdded))];
        NSString *catFullPath = [self pathForFilename:NSStringFromSelector(@selector(categories))];
        NSArray *storedSpotsItems = [NSKeyedUnarchiver unarchiveObjectWithFile:fullPath];
        NSArray *storedCatItems = [NSKeyedUnarchiver unarchiveObjectWithFile:catFullPath];
        self.locationManger = [CLLocationManager new];
        self.locationManger.delegate = self;
        [self.locationManger setDesiredAccuracy:kCLLocationAccuracyBest];
        [self.locationManger setDistanceFilter:kCLDistanceFilterNone];
        [self.locationManger startUpdatingLocation];
        if (storedSpotsItems.count == 0 || storedCatItems.count == 0) {
            [self addRandomData];
        }else {
            self.spotAdded = storedSpotsItems;
            self.categories = storedCatItems;
        }
        
        
        
        
    }
    return self;
}

-(void) addRandomData {
    NSMutableArray *randomSpotData = [NSMutableArray array];
    NSMutableArray *randomCatData = [NSMutableArray array];
    
    for (int i = 0; i <= 5; i++) {
        [randomSpotData addObject:[self addRandomSpot]];
        [randomCatData addObject:[self addRandomCategory]];
        ((EWESpot *) randomSpotData[i]).categoryID = ((EWECategory *)randomCatData[i]).identifier;
        ((EWESpot *) randomSpotData[i]).category = randomCatData[i];
    }
    
    self.spotAdded = randomSpotData;
    self.categories = randomCatData;
    
    if (self.spotAdded.count > 0 && self.categories > 0) {
        // Write the changes to disk
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSUInteger numberOfItemsToSave = MIN(self.spotAdded.count, 10);
            NSUInteger numberOfCatItemsToSave = MIN(self.categories.count, 10);
            NSArray *spotsToSave = [self.spotAdded subarrayWithRange:NSMakeRange(0, numberOfItemsToSave)];
            NSArray *catToSave = [self.categories subarrayWithRange:NSMakeRange(0, numberOfCatItemsToSave)];
            
            NSString *fullPath = [self pathForFilename:NSStringFromSelector(@selector(spotAdded))];
            NSString *catfullPath = [self pathForFilename:NSStringFromSelector(@selector(categories))];
            NSData *spotData = [NSKeyedArchiver archivedDataWithRootObject:spotsToSave];
            NSData *catData = [NSKeyedArchiver archivedDataWithRootObject:catToSave];
            
            NSError *dataError;
            BOOL wroteSuccessfully = [spotData writeToFile:fullPath options:NSDataWritingAtomic | NSDataWritingFileProtectionCompleteUnlessOpen error:&dataError];
            BOOL catwroteSuccessfully = [catData writeToFile:catfullPath options:NSDataWritingAtomic | NSDataWritingFileProtectionCompleteUnlessOpen error:&dataError];
            
            if (!wroteSuccessfully && !catwroteSuccessfully) {
                NSLog(@"Couldn't write file: %@", dataError);
            }
        });
        
    }

}

- (NSString *) pathForFilename:(NSString *) filename {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths firstObject];
    NSString *dataPath = [documentsDirectory stringByAppendingPathComponent:filename];
    return dataPath;
}



-(EWECategory *) addRandomCategory {
    NSString *randomName = [NSString randomStringOfLength:10];
    
    CGFloat red =  (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat blue = (CGFloat)random()/(CGFloat)RAND_MAX;
    CGFloat green = (CGFloat)random()/(CGFloat)RAND_MAX;
    
    UIColor *randomColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
    
        
    return [[EWECategory alloc] initWithName:randomName andColor:randomColor];
    
}

-(EWESpot *) addRandomSpot{
    EWESpot *testSpot = [[EWESpot alloc]init];
    
    NSUInteger wordCount = arc4random_uniform(20);
    
    NSMutableString *randomSentence = [[NSMutableString alloc] init];
    
    for (int i  = 0; i <= wordCount; i++) {
        NSString *randomWord = [NSString randomStringOfLength:arc4random_uniform(12)];
        [randomSentence appendFormat:@"%@ ", randomWord];
    }
    
    testSpot.note = randomSentence;
    testSpot.spotName = [NSString randomStringOfLength:10];
    testSpot.location =  CLLocationCoordinate2DMake((double)rand() / RAND_MAX, -(double)rand() / RAND_MAX);
    return testSpot;
    
    
}


- (EWECategory *) addNewCategory:(NSString *)name andColor:(UIColor *)color {
    EWECategory *newCategory = [[EWECategory alloc] initWithName:name andColor:color];
    // place in Array
    NSMutableArray *temp = [[NSMutableArray alloc]initWithArray:self.categories];
    [temp addObject:newCategory];
    self.categories = temp;
    return newCategory;
}
- (void) delCategory:(EWECategory *)category {
    

    NSMutableArray *temp = [[NSMutableArray alloc]initWithArray:self.categories];
    
    self.categories = [temp filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"ANY SELF == %@",category.name]];
    
    NSLog(@"%@",self.categories);
    
}

- (EWESpot *) addSpotName:(NSString *)name addSpotnote:(NSString *)note andLocation:(CLLocationCoordinate2D)location andCategory:(EWECategory *)category {
    EWESpot *newSpot = [[EWESpot alloc]initWithSpotName:name spotNote:note andLocation:location andCategory:category];
    
    NSMutableArray *temp = [[NSMutableArray alloc]initWithArray:self.spotAdded];
    
    [temp addObject:newSpot];
    self.spotAdded = temp;
    return newSpot;
    
}

#pragma mark - AddingLocation

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    self.currentCoord = [locations lastObject];
    
}

- (void) addNewCatForSpot: (EWECategory *)category {
    
    self.selectedCat = category;
    NSLog(@"%@",self.selectedCat.name);
    
}

- (void) newMapPoint:(MKMapItem *)mapPoint{
    self.mapPoint = mapPoint;
    NSLog(@"%f, %f",self.mapPoint.placemark.location.coordinate.latitude, self.mapPoint.placemark.location.coordinate.longitude);
}


@end
