//
//  EWECategoryTableViewController.m
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/8/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "EWECategoryTableViewController.h"
#import "EWEDatasource.h"
#import "EWESpot.h"
#import "EWECategory.h"
#import <QuartzCore/QuartzCore.h>

@interface EWECategoryTableViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UINavigationBar *navBar;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) UITapGestureRecognizer *theDoubeTap;
@end

@implementation EWECategoryTableViewController


- (instancetype) init {
    self = [super init];
    if (self) {
        NSMutableArray *categories = [@[] mutableCopy];
       
        for (EWECategory *spot in [EWEDatasource sharedInstance].categories) {
            [categories addObject:spot];
        }
        [categories sortUsingComparator:^NSComparisonResult(EWECategory *one, EWECategory *two) {
            return [one.name compare:two.name options:NSCaseInsensitiveSearch];
        }];
        self.categories = categories;
    }
    return self;
}


- (void)loadView {
    [super loadView];
    
    self.view = [[UIView alloc] init];
    self.tableView = [[UITableView alloc] init];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.navBar = [[UINavigationBar alloc] init];
    [self.view addSubview:self.navBar];
    self.theDoubeTap = [[UITapGestureRecognizer alloc]initWithTarget:self.view action:@selector(touchesBegan:withEvent:)];
    self.theDoubeTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:self.theDoubeTap];

}

// this is a little buggy it work but also when i tap on the bar as well
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    
    // Get location of the touch in view's coordinate system
    CGPoint location = [t locationInView:self.view];
    
    if ( [self.view hitTest:location withEvent:event])  {
            [self dismissViewControllerAnimated:YES completion:nil];
               }
    
    
    
    
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    self.tableView.layer.cornerRadius = 15;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    //making the frame size smaller
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    CGFloat widthHeight = 280;
    CGFloat paddingHorizontal = (self.view.frame.size.width - widthHeight) / 2;
    CGFloat topPadding = (self.view.frame.size.height - widthHeight) / 2;
    self.tableView.frame = CGRectMake(paddingHorizontal, topPadding, 280, 280);
    self.tableView.autoresizingMask = UIViewAutoresizingNone;
    
    CGRect navFrame = self.tableView.frame;
    self.navBar.frame = CGRectMake(CGRectGetMinX(navFrame), CGRectGetMinY(navFrame), CGRectGetWidth(navFrame), 50);
    self.tableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.categories count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EWECategory *category = [self.categories objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    // Configure the cell...
    cell.backgroundColor = category.color;
    [cell.textLabel setText:category.name];
    // if this category is selected
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    // else nothing
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
