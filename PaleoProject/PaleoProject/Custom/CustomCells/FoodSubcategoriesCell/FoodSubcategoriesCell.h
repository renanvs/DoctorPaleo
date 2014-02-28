//
//  FoodSubcategoriesCell.h
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodItemModel.h"

@interface FoodSubcategoriesCell : UITableViewCell{
    
    IBOutlet UIImageView *foodImage;
    IBOutlet UILabel *foodLabel;
    FoodItemModel *foodModel;
}

-(void)setItemModel:(FoodItemModel*)foodModel_;

@end
