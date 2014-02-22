//
//  FoodViewController.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FoodCategoryViewController.h"
#import "FoodCategoryCell.h"
#import "FoodSubcategoriesViewController.h"

@implementation FoodCategoryViewController

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:NavNameFoodCategory];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[PaleoFoodManager sharedInstance] categoryList].count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = CellCategoryName;
    
    FoodCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil]objectAtIndex:0];
    }
    
    [cell setCategoryModel:[[[PaleoFoodManager sharedInstance] categoryList] objectAtIndex:indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodCategoryModel *category = [[[PaleoFoodManager sharedInstance] categoryList] objectAtIndex:indexPath.row];
    FoodSubcategoriesViewController *foodSubcategoryViewContoller = [[FoodSubcategoriesViewController alloc] initWithItemList:[[PaleoFoodManager sharedInstance] getFoodListByCategory:category]];
    [self.navigationController pushViewController:foodSubcategoryViewContoller animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

@end
