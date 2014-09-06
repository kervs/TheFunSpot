//
//  EWESeachView.h
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/6/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EWESeachView;
@protocol EWESearchViewDelegate <NSObject>

-(void) seachViewDidPressCancelButton:(EWESeachView *)sender;

@end

@interface EWESeachView : UIView

@property (nonatomic, weak) NSObject <EWESearchViewDelegate> *delegate;

@end
