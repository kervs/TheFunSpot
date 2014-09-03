//
//  EWEMapViewController.m
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/3/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "EWEMapViewController.h"
#import <MapKit/MapKit.h>

@interface EWEMapViewController ()

@end

@implementation EWEMapViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.\ MKMapView *mapView = [[MKMapView alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
    MKMapView *mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    mapView.mapType = MKMapTypeStandard;
    mapView.zoomEnabled = YES;
    mapView.scrollEnabled = YES;
    mapView.showsUserLocation = YES;
    [self.view addSubview:mapView];
   
    
    
   
    
    
    
    
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
