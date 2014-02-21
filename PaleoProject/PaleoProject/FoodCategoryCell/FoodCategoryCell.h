//
//  FoodCategoryCell.h
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityFoodCategoryModel.h"

@interface FoodCategoryCell : UITableViewCell{
    EntityFoodCategoryModel *categoryModel;
}

@property (retain, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (retain, nonatomic) IBOutlet UILabel *categoryLabel;

-(void)setCategoryModel:(EntityFoodCategoryModel*)model;

@end
