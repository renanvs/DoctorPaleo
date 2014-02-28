//
//  FoodCategoryCell.h
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodCategoryModel.h"

@interface FoodCategoryCell : UITableViewCell{
    FoodCategoryModel *categoryModel;
}

@property (retain, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (retain, nonatomic) IBOutlet UILabel *categoryLabel;

-(void)setCategoryModel:(FoodCategoryModel*)categoryModel_;

@end
