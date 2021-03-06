//
//  FoodSubcategoriesViewController.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FoodSubcategoriesViewController.h"
#import "FoodSubcategoriesCell.h"
#import "FoodItemViewController.h"
#import "FoodCategoryModel.h"
#import "FoodItemModel.h"

@implementation FoodSubcategoriesViewController

#pragma mark - initial method's

- (id)initWithCategory:(FoodCategoryModel*)foodCategoryModel_{
    self = [super init];
    if (self) {
        foodModelList = [[NSArray alloc] initWithArray: [[PaleoFoodManager sharedInstance] getFoodListByCategory:foodCategoryModel_]];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellSelected:) name:CellFoodItemSelectd object:nil];
        foodCategoryModel = foodCategoryModel_;
        //gatodo: foodCategorymodel.name
    }
    return self;
}

#pragma mark - when view will/did appear

-(void)viewWillAppear:(BOOL)animated{
    //TODO: Subcategorias deve ser o titulo da categoria
    [self.navigationItem setTitle:foodCategoryModel.name];
    tableViewPaleo.delegateList = self;
    [PaleoGA trackScreen:FoodSubcategoriesScreen];
}

#pragma mark - tableView method's

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = CellFoodItemName;
    
    FoodSubcategoriesCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil]objectAtIndex:0];
    }
    
    FoodItemModel *foodModel = [tableViewPaleo getFoodModelByIndexPath:indexPath];
    [cell setItemModel:foodModel];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableViewPaleo getNumberOfRowsInSection:section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [tableViewPaleo getSectionCount];
}

-(NSArray *)foodItemList{
    return foodModelList;
}

#pragma mark - Notification's

-(void)cellSelected:(NSNotification*)notification{
    
    if ([[PaleoUtils sharedInstance] currentNavigationController] == [self navigationController]) {
        FoodItemModel *foodItemModel = (FoodItemModel*)notification.object;
        //gatodo: model.name model.category from foodsub
    }

}

@end
