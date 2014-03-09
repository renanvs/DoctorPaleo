//
//  FoodSubcategoriesViewController.h
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaleoFoodTableView.h"

@interface FoodSubcategoriesViewController : UIViewController <UITableViewDataSource, PaleoFoodTableViewDelegate>{
    NSArray *foodModelList;
    IBOutlet PaleoFoodTableView *tableViewPaleo;
    FoodCategoryModel *foodCategoryModel;
}

- (id)initWithCategory:(FoodCategoryModel*)foodCategoryModel_;

@end
