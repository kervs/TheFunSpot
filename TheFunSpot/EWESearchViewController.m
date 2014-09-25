//
//  EWESearchViewController.m
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/8/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "EWESearchViewController.h"
#import "EWEMapViewController.m"
#import <MapKit/MapKit.h>

@interface EWESearchViewController () <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong)UINavigationBar *navBar;
@property (nonatomic, strong)UIButton *cancelButton;
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *spotNames;


@end

@implementation EWESearchViewController


-(void)loadView
{
    
    self.view = [[UIView alloc]init];
    CGFloat width = self.view.frame.size.width;
    self.navBar = [[UINavigationBar alloc] initWithFrame:
                   CGRectMake(0,0,width,64)];
    _navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.navBar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:_navBar];
    self.spotNames = [[EWEMapViewController alloc]init].listOfLocation;
    self.tableView = [UITableView new];

    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.autoresizingMask = UIViewAutoresizingNone;
    [self.view addSubview:self.tableView];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat width = self.view.frame.size.width;
    self.navBar = [[UINavigationBar alloc] initWithFrame:
                   CGRectMake(0,0,self.view.bounds.size.width,64)];
    _navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:_navBar];
    
    self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(width - 30 - 40, 30, 60, 20)];
    [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
    
    
    
    [self.navBar addSubview:self.cancelButton];
    
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(20, 22, 280 - 60, 31)];
    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    self.textField.keyboardType = UIKeyboardTypeURL;
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
    self.textField.placeholder = NSLocalizedString(@"Search Fun Spots", @"Placeholder text for web browser URL field");
    self.textField.backgroundColor = [UIColor colorWithWhite:220/255.0f alpha:1];
    self.textField.delegate = self;
    
    
    [self.navBar addSubview:self.textField];
    
   
}


-(void)cancelButtonPressed{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.spotNames.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.spotNames objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    [cell.textLabel setText:location.listOfLocation];
    // if this category is selected
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    // else nothing

return cell
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
