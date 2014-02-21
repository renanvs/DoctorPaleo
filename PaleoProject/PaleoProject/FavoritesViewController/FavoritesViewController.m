//
//  FavoritesViewController.m
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FavoritesViewController.h"
#import "FoodSubcategoriesCell.h"

@interface FavoritesViewController ()

@end

@implementation FavoritesViewController

-(UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"FoodSubcategoriesCell";
    
    FoodSubcategoriesCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil]objectAtIndex:0];
    }
    
    EntityItemType *typeModel = [typeList objectAtIndex:indexPath.section];
    NSArray *itemListWithType = [dic objectForKey:typeModel.name];
    EntityItemModel *itemModel = [itemListWithType objectAtIndex:indexPath.row];
    
    [cell setItemModel:itemModel];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    EntityItemType *typeModel = [typeList objectAtIndex:section];
    NSArray *itemListWithType = [dic objectForKey:typeModel.name];
    
    return itemListWithType.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dic.count;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:@"Favoritos"];
    [self createObjects];
    tableView.delegateList = self;
    
}

-(NSArray *)itemList{
    return [[PaleoFoodManager sharedInstance] favoriteItens];
}

-(void)createObjects{
    itemList = [[PaleoFoodManager sharedInstance] favoriteItens];
    typeList = [[PaleoFoodManager sharedInstance] getTypeItemListWithItemList:itemList];
    dic = [[PaleoFoodManager sharedInstance] getDictionaryWithTypeList:typeList AndItemList:itemList];
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"appear");
}

-(void)viewDidDisappear:(BOOL)animated{
    [self createObjects];
    [tableView reloadData];
}



@end
