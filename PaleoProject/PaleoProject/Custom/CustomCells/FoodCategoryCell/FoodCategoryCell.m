//
//  FoodCategoryCell.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FoodCategoryCell.h"

@implementation FoodCategoryCell

- (void)dealloc {
    [_categoryImageView release];
    [_categoryLabel release];
    [super dealloc];
}

-(void)setCategoryModel:(FoodCategoryModel*)categoryModel_{
    categoryModel = categoryModel_;
    if ([categoryModel_.imageName isEqualToString:@"default.png"]) {
        categoryModel_.imageName = @"defaultImage.png";
    }
    self.categoryImageView.image = [UIImage imageNamed:categoryModel_.imageName];
    self.categoryLabel.text = categoryModel_.name;
}

@end
