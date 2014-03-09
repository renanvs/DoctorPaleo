//
//  FoodSubcategoriesCell.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FoodSubcategoriesCell.h"

@implementation FoodSubcategoriesCell

#pragma mark - set Model in UI

//Utiliza as informações do model para popular a célula
-(void)setItemModel:(FoodItemModel*)foodModel_{
    foodModel = foodModel_;
    foodLabel.text = foodModel_.name;
    if (![Utils existThisImage:foodModel.imageName]) {
        //gatodo: foodmodel.name sem imagem
        foodModel_.imageName = @"defaultImage.png";
    }
    foodImage.image = [UIImage imageNamed:foodModel_.imageName];
}

#pragma mark - finishing method's

- (void)dealloc {
    [foodImage release];
    [foodLabel release];
    [super dealloc];
}
@end
