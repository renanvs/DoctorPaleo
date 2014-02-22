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
    
    if (section == 0) {
        [topView setBackgroundColor:[UIColor redColor]];
    }
    
    if (section == 1) {
        [topView setBackgroundColor:[UIColor greenColor]];
    }
    
    if (section == 2) {
        [topView setBackgroundColor:[UIColor blueColor]];
    }
    
    if ([delegateList respondsToSelector:@selector(foodItemList)]) {
        foodList = [delegateList foodItemList];
    }
    
    if (!foodList || foodList.count == 0) {
        UIView *clearView = [[UIView alloc] init];
        [clearView setBackgroundColor:[UIColor clearColor]];
        return clearView;
    }
    
    NSArray *typeList = [[PaleoFoodManager sharedInstance] getFoodTypeListWithFoodList:foodList];
    FoodTypeModel *typeModel = [typeList objectAtIndex:section];
    [topView setTypeName:typeModel.name];
    
    return topView;
}

-(int)getSectionCount{

    if ([delegateList respondsToSelector:@selector(foodItemList)]) {
        foodList = [delegateList foodItemList];
    }
    
    if (!foodList || foodList.count == 0) {
        return 1;
    }

    NSArray *typeList = [[PaleoFoodManager sharedInstance] getFoodTypeListWithFoodList:foodList];
    NSDictionary *foodDictionary = [[PaleoFoodManager sharedInstance] getDictionaryWithFoodTypeList:typeList AndFoodList:foodList];
    return foodDictionary.count;

}

-(int)getNumberOfRowsInSection:(int)section{
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
    return 30;
}

@end
