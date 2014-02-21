//
//  FoodSubcategoriesCell.h
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityItemModel.h"

@interface FoodSubcategoriesCell : UITableViewCell{
    
    IBOutlet UIImageView *itemImage;
    IBOutlet UILabel *itemLabel;
    EntityItemModel *item;
}

-(void)setItemModel:(EntityItemModel*)itemModel;

@end
