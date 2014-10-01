//
//  EWEAddSpotViewController.m
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/27/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "EWEAddSpotViewController.h"
#import "EWEDatasource.h"
#import "EWESearchViewController.h"
#import "EWECategoryTableViewController.h"

@interface EWEAddSpotViewController () <UITextFieldDelegate>

@property (nonatomic, strong) UITextField *noteArea;

@end

@implementation EWEAddSpotViewController

-(void)loadView
{
    self.view = [[UIView alloc]init];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UILabel *nameOfSpotLabel = [[UILabel alloc] initWithFrame:CGRectMake(20,60,100,20)];
    nameOfSpotLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    nameOfSpotLabel.text = @"Spot Name:";
    nameOfSpotLabel.backgroundColor = [UIColor clearColor];
    nameOfSpotLabel.font = [UIFont fontWithName:@"Marker Felt" size:20];
    [self.view addSubview:nameOfSpotLabel];
    
    UILabel *nameOfSpotSelected = [[UILabel alloc] initWithFrame:CGRectMake(20,80,100,20)];
    nameOfSpotSelected.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    nameOfSpotSelected.numberOfLines = 0;
    nameOfSpotSelected.text =   [NSString stringWithFormat:@"%@",[EWEDatasource sharedInstance].mapPoint.name];
    NSLog(@"%@",[EWEDatasource sharedInstance].mapPoint.name);
    nameOfSpotSelected.backgroundColor = [UIColor clearColor];
    nameOfSpotSelected.font = [UIFont fontWithName:@"Marker Felt" size:20];
    [self.view addSubview:nameOfSpotSelected];
    
    UIButton *addCatButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 115, 280, 60)];
    [addCatButton setTitle:@"add category" forState:UIControlStateNormal];
    addCatButton.backgroundColor = [UIColor blueColor];
    [addCatButton addTarget:self action:@selector(addCatButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addCatButton];
    
    UILabel *notesOfSpot = [[UILabel alloc] initWithFrame:CGRectMake(20,190,100,20)];
    notesOfSpot.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    notesOfSpot.text = @"Add Notes:";
    notesOfSpot.backgroundColor = [UIColor clearColor];
    notesOfSpot.font = [UIFont fontWithName:@"Marker Felt" size:20];
    [self.view addSubview:notesOfSpot];
    
    self.noteArea = [[UITextField alloc] initWithFrame:CGRectMake(20, 220, 280, 200)];
    self.noteArea.borderStyle = UITextBorderStyleRoundedRect;
    self.noteArea.contentVerticalAlignment = UIControlContentVerticalAlignmentTop;
    self.noteArea.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    self.noteArea.delegate = self;
    self.noteArea.placeholder = @"Add any notes about you spot....";
    self.noteArea.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:self.noteArea];
    
    
    UIButton *addSpotButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 440, 280, 80)];
    [addSpotButton setTitle:@"Add Spot" forState:UIControlStateNormal];
    addSpotButton.backgroundColor = [UIColor blueColor];
    [addSpotButton addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addSpotButton];
    
    UIButton *cancelSpotButton = [[UIButton alloc]initWithFrame:CGRectMake(280, 20, 30, 30)];
    [cancelSpotButton setImage:[UIImage imageNamed:@"x"] forState:UIControlStateNormal];
    cancelSpotButton.backgroundColor = [UIColor clearColor];
    [cancelSpotButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelSpotButton];
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)cancelButtonPressed:(id) sender {
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addCatButtonPressed:(id) sender {
     EWECategoryTableViewController *selectCat = [[EWECategoryTableViewController alloc] initWithStyle:EWECategoryTableViewStyleSingleChoice];
    [self presentViewController:selectCat animated:NO completion:nil];
}

- (void)addButtonPressed:(id) sender {
    if ([EWEDatasource sharedInstance].selectedCat != nil) {
        [[EWEDatasource sharedInstance] addSpotName:[EWEDatasource sharedInstance].mapPoint.name addSpotnote:self.noteArea.text andLocation:[EWEDatasource sharedInstance].mapPoint.placemark.coordinate andCategory:[EWEDatasource sharedInstance].selectedCat];
        [self dismissViewControllerAnimated:YES completion:nil];
    } else
        NSLog(@"please select category");
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
