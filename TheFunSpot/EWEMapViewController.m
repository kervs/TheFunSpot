//
//  EWEMapViewController.m
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/4/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "EWEMapViewController.h"
#import <MapKit/MapKit.h>
#import "EWESearchViewController.h"
#import "EWEDatasource.h"
#import "EWESpot.h"
#import "EWECategory.h"
#import <CoreLocation/CoreLocation.h>


@interface EWEMapViewController () <MKMapViewDelegate, CLLocationManagerDelegate>
@property (nonatomic, strong)UINavigationBar *navBar;
@property (nonatomic, strong)MKMapView *mapView;
@property (nonatomic, strong)UIButton *searchButton;
@property (nonatomic, strong)UIButton *categoryButton;
@property (nonatomic, strong)UIButton *listButton;
@property (nonatomic, strong)CLLocationManager *locationManager;
@property (nonatomic, strong) NSMutableArray *listOfRegions;

@property (nonatomic, strong)EWEDatasource *dataSource;



@end

@implementation EWEMapViewController

- (instancetype) init {
    self = [super init];
    if (self) {
        

        
    }
    return self;
}


-(void)loadView
{
    
    self.view = [[UIView alloc]init];
    CGFloat width = self.view.frame.size.width;
    self.navBar = [[UINavigationBar alloc] initWithFrame:
                   CGRectMake(0,0,width,64)];
    _navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    [self.view addSubview:_navBar];
    
}

-(void)viewDidLoad{
    [super viewDidLoad];
   
    self.locationManager = [CLLocationManager new];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    self.locationManager.distanceFilter = kCLLocationAccuracyHundredMeters;
    
    self.listOfRegions = [NSMutableArray array];
    if ([CLLocationManager locationServicesEnabled]) {
        for (EWESpot *spot in [EWEDatasource sharedInstance].spotAdded) {
            CLCircularRegion *region = [[CLCircularRegion alloc] initWithCenter:spot.location radius:200.0 identifier:spot.spotName];
            [self.listOfRegions addObject:region];
        }
        for (int i; i < self.listOfRegions.count; i++) {
            [self.locationManager startMonitoringForRegion:self.listOfRegions[i]];
        }
    }
    NSLog(@"regions %@",[self.locationManager monitoredRegions]);
}

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    NSLog(@"you are here ");
    
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    // Do any additional setup after loading the view.
    CGFloat width = self.view.frame.size.width;
    
    

    self.mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 64, width, self.view.bounds.size.height - 64)];
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.zoomEnabled = YES;
    self.mapView.scrollEnabled = YES;
    self.mapView.showsUserLocation = YES;
    [self.view addSubview:self.mapView];
    
    
    
    self.listButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 30, 20)];
    [self.listButton setImage:[UIImage imageNamed:@"list"] forState:UIControlStateNormal];
    [self.listButton addTarget:self action:@selector(listButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.listButton.autoresizingMask = UIViewAutoresizingFlexibleRightMargin;
    [self.navBar addSubview:self.listButton];
    
    self.categoryButton = [[UIButton alloc]initWithFrame:CGRectMake(width - 30 - 10, 30, 20, 20)];
    [self.categoryButton setImage:[UIImage imageNamed:@"cate"] forState:UIControlStateNormal];
    self.categoryButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self.navBar addSubview:self.categoryButton];
    
    self.searchButton = [[UIButton alloc]initWithFrame:CGRectMake((width - 60 - 20), 30, 20, 20)];
    [self.searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(searchButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.searchButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    [self.navBar addSubview:self.searchButton];
    
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(130,30,150,20)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.text = @"FunSpot";
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Marker Felt" size:20];
    [self.navBar addSubview:label];
    
  
    
}



-(void)listButtonPressed {
    [self dismissViewControllerAnimated:YES completion:nil];
}



//- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    MKPinAnnotationView *view = [[MKPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:@"pin"];
//    view.pinColor = MKPinAnnotationColorGreen;
//    view.enabled = YES;
//    view.animatesDrop = YES;
//    view.canShowCallout = YES;
//    return view;
//    
//}
-(void) mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
   
    for (EWESpot *spot in [EWEDatasource sharedInstance].spotAdded) {
        MKPointAnnotation *thePoint = [[MKPointAnnotation alloc]init];
        thePoint.title = spot.spotName;
        thePoint.coordinate = spot.location;
        [self.mapView addAnnotation:thePoint];
    }
    
    EWESpot *spot;
    CLLocationCoordinate2D coord = spot.location;
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 2000.0, 2000.0);
    
    [self.mapView setRegion:region animated:YES];

}

-(void)searchButtonPressed {
    
  
    EWESearchViewController *searchView = [[EWESearchViewController alloc]init];
    [self presentViewController:searchView animated:YES completion:nil];

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
