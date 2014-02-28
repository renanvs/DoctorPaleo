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

- (id)initWithItemList:(NSArray*)foodModelList_{
    self = [super init];
    if (self) {
        foodModelList = [[NSArray alloc] initWithArray:foodModelList_];
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    //TODO: Subcategorias deve ser o titulo da categoria
    [self.navigationItem setTitle:@"Subcategorias"];
    tableViewPaleo.delegateList = self;
}

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

@end
