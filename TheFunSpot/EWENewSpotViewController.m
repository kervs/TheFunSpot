//
//  EWENewSpotViewController.m
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/24/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "EWENewSpotViewController.h"

@interface EWENewSpotViewController () <UITextFieldDelegate>


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UINavigationBar *navBar;
@property (nonatomic, strong) NSArray *categories;
@property (nonatomic, strong) UITapGestureRecognizer *theDoubeTap;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UITextField *inputText;

@end

@implementation EWENewSpotViewController

- (void)loadView {
    [super loadView];
    
    self.view = [[UIView alloc] init];
    
    self.navBar = [[UINavigationBar alloc] init];
    [self.view addSubview:self.navBar];
    self.theDoubeTap = [[UITapGestureRecognizer alloc]initWithTarget:self.view action:@selector(touchesBegan:withEvent:)];
    self.theDoubeTap.numberOfTapsRequired = 2;
    self.addButton = [[UIButton alloc] init];
    [self.addButton setTitle:@"Add" forState:UIControlStateNormal];
    [self.addButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.navBar addSubview:self.addButton];
    [self.view addGestureRecognizer:self.theDoubeTap];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *t = [touches anyObject];
    
    // Get location of the touch in view's coordinate system
    CGPoint location = [t locationInView:self.view];
    
    if ( [self.view hitTest:location withEvent:event])  {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    //making the frame size smaller
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    CGFloat widthHeight = 280;
    CGFloat paddingHorizontal = (self.view.frame.size.width - widthHeight) / 2;
    CGFloat topPadding = (self.view.frame.size.height - widthHeight) / 2;
    self.view.frame = CGRectMake(paddingHorizontal, topPadding, 280, 280);
    self.view.autoresizingMask = UIViewAutoresizingNone;
    
    CGRect navFrame = self.tableView.frame;
    self.navBar.frame = CGRectMake(CGRectGetMinX(navFrame), CGRectGetMinY(navFrame), CGRectGetWidth(navFrame), 50);
    
    self.addButton.frame = CGRectMake(widthHeight - 15 - 50, 0, 60, 50);
    NSLog(@"Button frame %@", NSStringFromCGRect(self.addButton.frame));
    [self.addButton addTarget:self action:@selector(addButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
