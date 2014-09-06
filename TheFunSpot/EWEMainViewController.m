//
//  EWEMainViewController.m
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/3/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "EWEMainViewController.h"
#import "EWEMapViewController.h"


@interface EWEMainViewController ()

@property (nonatomic, strong)UINavigationBar *navBar;
@property (nonatomic, strong)UIButton *mapButton;
@property (nonatomic, strong)UIButton *searchButton;
@property (nonatomic, strong)UIButton *categoryButton;


@end

@implementation EWEMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGFloat width = self.view.frame.size.width;
    // Do any additional setup after loading the view.
    self.mapButton = [[UIButton alloc]initWithFrame:CGRectMake(20, 30, 20, 20)];
    [self.mapButton setImage:[UIImage imageNamed:@"map"] forState:UIControlStateNormal];
    [self.mapButton addTarget:self action:@selector(mapButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    //shadowing buttons
    self.mapButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.mapButton.layer.shadowOffset = CGSizeMake(3.0f, 5.0f);
    self.mapButton.layer.masksToBounds = NO;
    self.mapButton.layer.shadowRadius = 3.0f;
    self.mapButton.layer.shadowOpacity = 1.0f;
    [self.navBar addSubview:self.mapButton];
    
    self.categoryButton = [[UIButton alloc]initWithFrame:CGRectMake(width - 30 - 10, 30, 20, 20)];
    [self.categoryButton setImage:[UIImage imageNamed:@"cate"] forState:UIControlStateNormal];
    self.categoryButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
    //shadowing buttons
    self.categoryButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.categoryButton.layer.shadowOffset = CGSizeMake(3.0f, 5.0f);
    self.categoryButton.layer.masksToBounds = NO;
    self.categoryButton.layer.shadowRadius = 3.0f;
    self.categoryButton.layer.shadowOpacity = 1.0f;
    [self.navBar addSubview:self.categoryButton];
    
    
    self.searchButton = [[UIButton alloc]initWithFrame:CGRectMake((width - 60 - 20), 30, 20, 20)];
    [self.searchButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    self.searchButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
    //shadowing buttons
    self.searchButton.layer.shadowColor = [UIColor blackColor].CGColor;
    self.searchButton.layer.shadowOffset = CGSizeMake(3.0f, 5.0f);
    self.searchButton.layer.masksToBounds = NO;
    self.searchButton.layer.shadowRadius = 3.0f;
    self.searchButton.layer.shadowOpacity = 1.0f;
    [self.navBar addSubview:self.searchButton];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(145,30,width-20,20)];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.text = @"FunSpot";
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont fontWithName:@"Marker Felt" size:20];
    [self.navBar addSubview:label];
    
    
    
    
}

-(void) mapButtonPressed{

    EWEMapViewController *mapView = [[EWEMapViewController alloc]init];
    [self presentViewController:mapView animated:YES completion:nil];
    
    
    
}

-(void) searchButtonPressed{

    
}
-(void)categoryButtonPressed{
    
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
