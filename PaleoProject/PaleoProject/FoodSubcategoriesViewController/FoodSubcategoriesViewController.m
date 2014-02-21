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

#import "EntityFoodCategoryModel.h"
#import "EntityItemModel.h"

@interface FoodSubcategoriesViewController ()

@end

@implementation FoodSubcategoriesViewController

- (id)initWithItemList:(NSArray*)itemList{
    self = [super init];
    if (self) {
        itemModelList = [[NSArray alloc] initWithArray:itemList];
        itemTypeList = [[PaleoFoodManager sharedInstance] getTypeItemListWithItemList:itemModelList];
        dic = [[PaleoFoodManager sharedInstance] getDictionaryWithTypeList:itemTypeList AndItemList:itemModelList];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"FoodSubcategoriesCell";
    
    FoodSubcategoriesCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil]objectAtIndex:0];
    }
    
    EntityItemType *itemType = [itemTypeList objectAtIndex:indexPath.section];
    NSArray *itemListWithType = [dic objectForKey:itemType.name];
    EntityItemModel *itemModel = [itemListWithType objectAtIndex:indexPath.row];
    
    [cell setItemModel:itemModel];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    PaleoItemTableView *paleoTableView = (PaleoItemTableView*)tableView;
    paleoTableView.delegateList = self;
    
    EntityItemType *itemType = [itemTypeList objectAtIndex:section];
    NSArray *itemListWithType = [dic objectForKey:itemType.name];
    return itemListWithType.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return dic.count;
}

-(NSArray *)itemList{
    return itemModelList;
}

@end
