//
//  EWESearchViewController.m
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/8/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "EWESearchViewController.h"
#import "EWEMapViewController.h"
#import "EWEDatasource.h"
#import <MapKit/MapKit.h>

@interface EWESearchViewController () <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate> {
    BOOL isSearching;
}



@property (nonatomic, strong)UISearchBar *searchBar;
@property (nonatomic, strong)UISearchDisplayController *searchBarController;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *placesNear;
@property (nonatomic, strong)NSArray *cacheSpot;


@end

@implementation EWESearchViewController


-(void)loadView
{
    
    self.view = [[UIView alloc]init];
    self.tableView = [UITableView new];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingNone;
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.placesNear = [[NSMutableArray  alloc]init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.cacheSpot = [EWEDatasource sharedInstance].spotAdded;
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
    self.searchBar.showsCancelButton = YES;
    self.searchBar.keyboardType = UIKeyboardTypeURL;
    self.searchBar.returnKeyType = UIReturnKeyDone;
    self.searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    self.searchBar.placeholder = NSLocalizedString(@"Search Fun Spots", @"Placeholder text for web browser URL field");
    self.searchBar.backgroundColor = [UIColor colorWithWhite:220/255.0f alpha:1];
    
    self.searchBar.delegate = self;
    
    
    [self.view addSubview:self.searchBar];
}

-(void) searchThroughChacheData{
    
        NSMutableArray *temp = [[NSMutableArray alloc]initWithArray:[EWEDatasource sharedInstance].spotAdded];
        
        self.cacheSpot = [temp filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"spotName contains  %@",self.searchBar.text]];
        [self.tableView reloadData];
    

}

- (void) searchTableList {
    
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = self.searchBar.text;
    request.region = MKCoordinateRegionMakeWithDistance([EWEDatasource sharedInstance].currentCoord.coordinate, 500, 500);
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        if ([request.naturalLanguageQuery isEqualToString:self.searchBar.text] == NO) {
            return;
        }
        for (MKMapItem *mapItem in [response mapItems]) {
            NSLog(@"Map Items: %@, Placemark title: %f", mapItem.name,[[mapItem placemark]coordinate].latitude);
            [self.placesNear addObject:mapItem];
        }
        
        [self.tableView reloadData];
        
        
        
    }];
    
    
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"Text change - %d",isSearching);
    
    //Remove all objects first.
    [self.placesNear removeAllObjects];
    
    if([searchText length] != 0) {
        isSearching = YES;
        [self searchTableList];
        [self searchThroughChacheData];
        
        
    }
    else {
        isSearching = NO;
    }
    //[self.tableView reloadData];
}
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    isSearching = YES;
}

-(void) viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    CGFloat width = self.view.frame.size.width;
    self.tableView.frame = CGRectMake(0, 64, width, self.view.frame.size.height - 64);
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
    {   return self.cacheSpot.count;
        if (isSearching){
            return self.cacheSpot.count;
        }
    }
    if (section == 1)
    {
        if (isSearching)
            return self.placesNear.count;
        
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
    {
        return @"FunSpots";
    }
    if(section == 1)
    {
        return @"Google result";
    } else
        return @"";
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.section==0) {
        EWESpot *spot = [self.cacheSpot objectAtIndex:indexPath.row];
        
        cell.textLabel.text = spot.spotName;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    else {
        
        
        if(isSearching){
            if (indexPath.section == 0) {
                EWESpot *spot = [self.cacheSpot objectAtIndex:indexPath.row];
                
                cell.textLabel.text = spot.spotName;
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            } else{
                MKMapItem *mapItem = [self.placesNear objectAtIndex:indexPath.row];
                [cell.textLabel setText:mapItem.name];
                cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
        }
        
        
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        
    } else {
        
    }
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
