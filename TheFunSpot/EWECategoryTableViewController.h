//
//  EWECategoryTableViewController.h
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/8/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EWECategoryTableViewController;
@class EWECategory;

@protocol EWECategoryTableViewControllerDelegate <NSObject>
@optional
- (void)EWECategoryTableViewController:(EWECategoryTableViewController *)controller didSelectCategory:(EWECategory *)category;
- (void)EWECategoryTableViewController:(EWECategoryTableViewController *)controller didDeselectCategory:(EWECategory *)category;
@end

typedef NS_ENUM(NSUInteger, EWECategoryTableViewStyle) {
    EWECategoryTableViewStyleMultiChoice,
    EWECategoryTableViewStyleSingleChoice
};

@interface EWECategoryTableViewController : UIViewController

-(instancetype) initWithStyle:(EWECategoryTableViewStyle)aStyle;

@end
