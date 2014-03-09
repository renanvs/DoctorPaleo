//
//  FoodCategoryCell.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FoodCategoryCell.h"

@implementation FoodCategoryCell

#pragma mark - finishing method's

- (void)dealloc {
    [_categoryImageView release];
    [_categoryLabel release];
    [super dealloc];
}

#pragma mark - set Model in UI

//Utiliza as informações do model para popular a célula
-(void)setCategoryModel:(FoodCategoryModel*)categoryModel_{
    categoryModel = categoryModel_;
    if (![Utils existThisImage:categoryModel_.imageName]) {
        //gatodo: categoryMode.name sem imagem
        categoryModel_.imageName = @"defaultImage.png";
    }
    self.categoryImageView.image = [UIImage imageNamed:categoryModel_.imageName];
    self.categoryLabel.text = categoryModel_.name;
}

@end
