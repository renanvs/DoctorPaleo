//
//  PaleoItemTableView.m
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoFoodTableView.h"
#import "FoodItemViewController.h"

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

//TODO: Fazer Headers
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    if (section == 0) {
        [view setBackgroundColor:[UIColor redColor]];
    }
    
    if (section == 1) {
        [view setBackgroundColor:[UIColor greenColor]];
    }
    
    if (section == 2) {
        [view setBackgroundColor:[UIColor blueColor]];
    }
    
    return view;
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

@end
