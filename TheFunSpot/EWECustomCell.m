//
//  EWECustomCell.m
//  TheFunSpot
//
//  Created by Kervins Valcourt on 10/1/14.
//  Copyright (c) 2014 EastoftheWestEnd. All rights reserved.
//

#import "EWECustomCell.h"
@interface EWECustomCell ()
@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *distanceLabel;

@end

static UIFont *lightFont;
static UIFont *boldFont;

@implementation EWECustomCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.imageview = [[UIImageView alloc] init];
        self.distanceLabel = [[UILabel alloc] init];
        self.nameLabel = [[UILabel alloc] init];
        self.descriptionLabel = [[UILabel alloc] init];
        self.descriptionLabel.numberOfLines = 2;
        
        for (UIView *view in @[self.imageview, self.distanceLabel, self.nameLabel, self.descriptionLabel]) {
            [self.contentView addSubview:view];
            
        }
        
    }
    return self;
}

+ (void)load {
    lightFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
    boldFont = [UIFont fontWithName:@"HelveticaNeue-Bold" size:11];
}

- (NSAttributedString *)nameLabelString {
    CGFloat spotNameFontSize = 15;
    NSString *baseString = [NSString stringWithFormat:@"%@",self.spot.spotName];
    NSMutableAttributedString *mutableSpotName = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : [boldFont fontWithSize:spotNameFontSize]}];
    return mutableSpotName;
}



- (NSAttributedString *)descriptionLabelString {
    
    NSString *baseString = [NSString stringWithFormat:@"%@",self.spot.note];
    NSMutableAttributedString *mutableDescriptionSpot = [[NSMutableAttributedString alloc] initWithString:baseString attributes:@{NSFontAttributeName : lightFont}];
    return mutableDescriptionSpot;
}

- (CGSize) sizeOfString:(NSAttributedString *)string {
    CGSize maxSize = CGSizeMake(CGRectGetWidth(self.contentView.bounds) - 40, 0.0);
    CGRect sizeRect = [string boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil];
    sizeRect.size.height += 20;
    sizeRect = CGRectIntegral(sizeRect);
    return sizeRect.size;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    
    
    self.imageview.frame = CGRectMake(20, 20, 30, 30);
    
    self.distanceLabel.frame = CGRectMake(20, 50, 30, 30);
    
    CGSize sizeNameLabel = [self sizeOfString:self.nameLabel.attributedText];
    self.nameLabel.frame = CGRectMake(60, 15, CGRectGetWidth(self.contentView.bounds) - 40, sizeNameLabel.height - 10);
    
    CGSize sizeOfDescriptionLabel = [self sizeOfString:self.descriptionLabel.attributedText];
    self.descriptionLabel.frame = CGRectMake(60, CGRectGetMaxY(self.nameLabel.frame), 250, sizeOfDescriptionLabel.height);
    
}

- (void)setSpot:(EWESpot *)spot {
    _spot = spot;
    self.imageview.image = [UIImage imageNamed:@"red"];
    self.nameLabel.attributedText = [self nameLabelString];
    self.descriptionLabel.attributedText = [self descriptionLabelString];
    self.distanceLabel.text = @"<.1 mi";
    self.distanceLabel.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:11];
}













@end
