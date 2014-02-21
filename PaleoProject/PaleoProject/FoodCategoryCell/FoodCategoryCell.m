//
//  FoodCategoryCell.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FoodCategoryCell.h"

@implementation FoodCategoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [_categoryImageView release];
    [_categoryLabel release];
    [super dealloc];
}

-(void)setCategoryModel:(EntityFoodCategoryModel*)model{
    categoryModel = model;
    self.categoryImageView.image = [UIImage imageNamed:model.imageName];
    self.categoryLabel.text = model.name;
}

@end
