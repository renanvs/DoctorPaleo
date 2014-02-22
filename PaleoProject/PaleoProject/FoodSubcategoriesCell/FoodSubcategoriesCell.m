//
//  FoodSubcategoriesCell.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FoodSubcategoriesCell.h"

@implementation FoodSubcategoriesCell

-(void)setItemModel:(FoodItemModel*)foodModel_{
    foodModel = foodModel_;
    foodLabel.text = foodModel_.name;
    foodImage.image = [UIImage imageNamed:foodModel_.imageName];
}

- (void)dealloc {
    [foodImage release];
    [foodLabel release];
    [super dealloc];
}
@end
