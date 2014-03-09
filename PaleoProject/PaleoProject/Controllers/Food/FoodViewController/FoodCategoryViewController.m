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

#pragma mark - when view will/did appear

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:NavNameFoodCategory];
    [PaleoGA trackScreen:FoodCategoryScreen];
    originaRect = foodTableView.frame;
    CGRect screenRect = screenBounds();
    [foodTableView setY:-screenRect.size.height];
}

-(void)viewDidAppear:(BOOL)animated{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.1];
    [foodTableView setY:originaRect.origin.y];
    [UIView commitAnimations];
}

#pragma mark - tableView method's

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
    FoodSubcategoriesViewController *foodSubcategoryViewContoller = [[FoodSubcategoriesViewController alloc] initWithCategory:category];
    //gatodo: category.name selected
    [self.navigationController pushViewController:foodSubcategoryViewContoller animated:YES];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

@end
