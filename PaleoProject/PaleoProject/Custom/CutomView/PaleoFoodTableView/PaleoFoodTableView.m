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

//todo: tentar extrair chamadas duplicadas nessa classe

#pragma mark - intial method's

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
    }
    return self;
}

#pragma mark - TableView Delegate Method's

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([delegateList respondsToSelector:@selector(foodItemList)]) {
        foodList = [delegateList foodItemList];
    }
    
    if (!foodList) {
        return;
    }
    
    //Pega o FoodItemModel pelo indexPath e apresenta o FoodItemViewController passando o FoodItemModel
    FoodItemModel *foodModel = [self getFoodModelByIndexPath:indexPath];
    FoodItemViewController *foodItemViewController = [[FoodItemViewController alloc] initWithItemModel:foodModel];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:CellFoodItemSelectd object:foodModel];
    //gatodo: foodmodel.name foodmodel.category.name selected
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
    
    
    FoodTypeModel *typeModel = [self getTypeModelWithSection:section];
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

#pragma mark - Filter Method's

//Retorna o numero de seções baseado na lista de FoodItemModel
-(NSInteger)getSectionCount{

    if ([delegateList respondsToSelector:@selector(foodItemList)]) {
        foodList = [delegateList foodItemList];
    }
    
    if (!foodList || foodList.count == 0) {
        return 0;
    }

    NSDictionary *foodDictionary = [[PaleoFoodManager sharedInstance] getDictionaryWithFoodList:foodList];
    return foodDictionary.count;

}

//Retorna o numero de itens na seção, baseado na lista de FoodItemModel e na section
-(NSInteger)getNumberOfRowsInSection:(NSInteger)section{
    if ([delegateList respondsToSelector:@selector(foodItemList)]) {
        foodList = [delegateList foodItemList];
    }

     if (!foodList || foodList.count == 0) {
        return 0;
    }

    FoodTypeModel *typeModel = [self getTypeModelWithSection:section];
    NSDictionary *foodDictionary = [[PaleoFoodManager sharedInstance] getDictionaryWithFoodList:foodList];
    NSArray *foodListInCurrentType = [foodDictionary objectForKey:typeModel.name];
    
    return foodListInCurrentType.count;
}

//Retorna o FoodItemModel baseado na lista de FoodItemModel e o indexPath
-(FoodItemModel*)getFoodModelByIndexPath:(NSIndexPath*)indexPath{

    if ([delegateList respondsToSelector:@selector(foodItemList)]) {
        foodList = [delegateList foodItemList];
    }

     if (!foodList || foodList.count == 0) {
        return nil;
    }
    
    FoodTypeModel *typeModel = [self getTypeModelWithSection:indexPath.section];
    NSDictionary *foodDictionary = [[PaleoFoodManager sharedInstance] getDictionaryWithFoodList:foodList];
    NSArray *itemListWithType = [foodDictionary objectForKey:typeModel.name];
    FoodItemModel *foodModel = [itemListWithType objectAtIndex:indexPath.row];

    return foodModel;
}

//Pega FoodTypeModel atraves do section
-(FoodTypeModel*)getTypeModelWithSection:(int)section{
    if ([delegateList respondsToSelector:@selector(foodItemList)]) {
        foodList = [delegateList foodItemList];
    }
    
    NSArray *typeList = [[PaleoFoodManager sharedInstance] getFoodTypeListWithFoodList:foodList];
    FoodTypeModel *typeModel = [typeList objectAtIndex:section];
    
    return typeModel;
}

#pragma mark - remove cell and item

//remove a linha ou seção da tabela
-(void)removeItemFromTableViewAtIndex:(NSIndexPath*)index{
    if ([delegateList respondsToSelector:@selector(foodItemList)]) {
        foodList = [delegateList foodItemList];
    }
    
    if (!foodList || foodList.count == 0) {
        return;
    }
    
    NSArray *indexPathList = [NSArray arrayWithObject:index];
    
    FoodItemModel *foodItem = [self getFoodModelByIndexPath:index];
    [[PaleoFoodManager sharedInstance] removeItemFromFavorites:foodItem];
    
    //gatodo: removendo item dos favoritos, passar o nome do item e a categoria
    
    //Pega a lista de FoodItemModel baseado na seção atual para saber se remove a seção (se houver apenas um item na lista)
    // ou remove a linha (caso haja mais de um item lista)
    NSDictionary *dic = [[PaleoFoodManager sharedInstance] getDictionaryWithFoodList:foodList];
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
