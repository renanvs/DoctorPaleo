//
//  PaleoItemTableView.m
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoFoodTableView.h"
#import "FoodItemViewController.h"
#import "FoodSubcategoryHeadView.h"

@implementation PaleoFoodTableView
@synthesize delegateList;

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
    }
    return self;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([delegateList respondsToSelector:@selector(foodItemList)]) {
        foodList = [delegateList foodItemList];
    }
    
    if (!foodList) {
        return;
    }
    
    NSArray *typeList = [[PaleoFoodManager sharedInstance] getFoodTypeListWithFoodList:foodList];
    FoodTypeModel *typeModel = [typeList objectAtIndex:indexPath.section];
    NSDictionary *foodDictionary = [[PaleoFoodManager sharedInstance] getDictionaryWithFoodTypeList:typeList AndFoodList:foodList];
    NSArray *foodListInCurrentType = [foodDictionary objectForKey:typeModel.name];
    FoodItemModel *foodModel = [foodListInCurrentType objectAtIndex:indexPath.row];
    FoodItemViewController *foodItemViewController = [[FoodItemViewController alloc] initWithItemModel:foodModel];
    
    [[PaleoUtils sharedInstance] pushViewControllerInCurrentNavigationController:foodItemViewController];

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    FoodSubcategoryHeadView *topView = [[[NSBundle mainBundle] loadNibNamed:@"FoodSubcategoryHeadView" owner:self options:nil] lastObject];
    
    if ([delegateList respondsToSelector:@selector(foodItemList)]) {
        foodList = [delegateList foodItemList];
    }
    
    if (!foodList) {
        UIView *clearView = [[UIView alloc] init];
        [clearView setBackgroundColor:[UIColor clearColor]];
        return clearView;
    }
    
    
    NSArray *typeList = [[PaleoFoodManager sharedInstance] getFoodTypeListWithFoodList:foodList];
    FoodTypeModel *typeModel = [typeList objectAtIndex:section];
    [topView setTypeName:typeModel.name];
    
    if ([typeModel.name isEqualToString:@"Paleo"]) {
        topView.headBackgroundImageView.image = [UIImage imageNamed:@"foodItemTopCellBorder1.png"];
    }else if ([typeModel.name isEqualToString:@"Low-Carb"]) {
        topView.headBackgroundImageView.image = [UIImage imageNamed:@"foodItemTopCellBorder2.png"];
    }else if ([typeModel.name isEqualToString:@"Não LowCarb"]) {
        topView.headBackgroundImageView.image = [UIImage imageNamed:@"foodItemTopCellBorder3.png"];
    }
    
    return topView;
}

-(NSInteger)getSectionCount{

    if ([delegateList respondsToSelector:@selector(foodItemList)]) {
        foodList = [delegateList foodItemList];
    }
    
    if (!foodList || foodList.count == 0) {
        return 0;
    }

    NSArray *typeList = [[PaleoFoodManager sharedInstance] getFoodTypeListWithFoodList:foodList];
    NSDictionary *foodDictionary = [[PaleoFoodManager sharedInstance] getDictionaryWithFoodTypeList:typeList AndFoodList:foodList];
    return foodDictionary.count;

}

-(NSInteger)getNumberOfRowsInSection:(NSInteger)section{
    if ([delegateList respondsToSelector:@selector(foodItemList)]) {
        foodList = [delegateList foodItemList];
    }

     if (!foodList || foodList.count == 0) {
        return 0;
    }

    NSArray *typeList = [[PaleoFoodManager sharedInstance] getFoodTypeListWithFoodList:foodList];
    FoodTypeModel *typeModel = [typeList objectAtIndex:section];
    NSDictionary *foodDictionary = [[PaleoFoodManager sharedInstance] getDictionaryWithFoodTypeList:typeList AndFoodList:foodList];
    NSArray *foodListInCurrentType = [foodDictionary objectForKey:typeModel.name];
    
    return foodListInCurrentType.count;
}

-(FoodItemModel*)getFoodModelByIndexPath:(NSIndexPath*)indexPath{

    if ([delegateList respondsToSelector:@selector(foodItemList)]) {
        foodList = [delegateList foodItemList];
    }

     if (!foodList || foodList.count == 0) {
        return nil;
    }
    
    NSArray *typeList = [[PaleoFoodManager sharedInstance] getFoodTypeListWithFoodList:foodList];
    FoodTypeModel *typeModel = [typeList objectAtIndex:indexPath.section];
    NSDictionary *foodDictionary = [[PaleoFoodManager sharedInstance] getDictionaryWithFoodTypeList:typeList AndFoodList:foodList];
    NSArray *itemListWithType = [foodDictionary objectForKey:typeModel.name];
    FoodItemModel *foodModel = [itemListWithType objectAtIndex:indexPath.row];

    return foodModel;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

-(void)removeItemFromTableViewAtIndex:(NSIndexPath*)index{
    if ([delegateList respondsToSelector:@selector(foodItemList)]) {
        foodList = [delegateList foodItemList];
    }
    
    if (!foodList || foodList.count == 0) {
        return;
    }
    
    NSArray *indexPathList = [NSArray arrayWithObject:index];
    FoodItemModel *foodItem = [[PaleoFoodManager sharedInstance] findFoodItemByIndex:index AtList:foodList];
    [[PaleoFoodManager sharedInstance] removeItemFromFavorites:foodItem];
    
    
    NSArray *types = [[PaleoFoodManager sharedInstance] getFoodTypeListWithFoodList:foodList];
    NSDictionary *dic = [[PaleoFoodManager sharedInstance] getDictionaryWithFoodTypeList:types AndFoodList:foodList];
    
    NSString *desireKey = [[dic allKeys] objectAtIndex:index.section];
    NSArray *currentList = [dic objectForKey:desireKey];
    
    if (currentList.count == 1) {
        NSIndexSet *set = [NSIndexSet indexSetWithIndex:index.section];
        [self deleteSections:set withRowAnimation:UITableViewRowAnimationLeft];
    }else{
        [self deleteRowsAtIndexPaths:indexPathList withRowAnimation:UITableViewRowAnimationLeft];
    }
}

@end
