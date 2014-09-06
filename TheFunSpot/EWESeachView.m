//
//  EWESeachView.m
//  TheFunSpot
//
//  Created by Kervins Valcourt on 9/6/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "EWESeachView.h"
@interface EWESeachView ()<UITextFieldDelegate>
@property (nonatomic,strong) UINavigationBar *navBar;
@property (nonatomic,strong) UIButton *cancelButton;
@property (nonatomic, strong) UITextField *textField;
@end

@implementation EWESeachView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        UIView *view = [[UIView alloc]init];
        
        self.navBar = [[UINavigationBar alloc] initWithFrame:
                       CGRectMake(0,0,self.bounds.size.width,64)];
        _navBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [view addSubview:_navBar];
        
        self.cancelButton = [[UIButton alloc]init];
        [self.cancelButton setTitle:@"Cancel" forState:UIControlStateNormal];
        [self.cancelButton addTarget:self action:@selector(cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.navBar addSubview:self.cancelButton];
        
        self.textField = [[UITextField alloc] init];
        self.textField.keyboardType = UIKeyboardTypeURL;
        self.textField.returnKeyType = UIReturnKeyDone;
        self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        self.textField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.textField.placeholder = NSLocalizedString(@"Search Fun Spots", @"Placeholder text for web browser URL field");
        self.textField.backgroundColor = [UIColor colorWithWhite:220/255.0f alpha:1];
        self.textField.delegate = self;
        
        [self.navBar addSubview:self.textField];
        
    }
    return self;
}
- (void) layoutSubviews {
    [super layoutSubviews];
    self.textField.frame = CGRectMake(20, 20, self.bounds.size.width - 40, 40);
    self.cancelButton.frame = CGRectMake(self.bounds.size.width - 30 - 10, 30, 20, 20);
}

- (void) cancelPressed {
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
