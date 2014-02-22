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

@implementation FoodSubcategoriesViewController

- (id)initWithItemList:(NSArray*)itemList{
    self = [super init];
    if (self) {
        itemModelList = [[NSArray alloc] initWithArray:itemList];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:@"Subcategorias"];
    tableViewPaleo.delegateList = self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"FoodSubcategoriesCell";
    
    FoodSubcategoriesCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil]objectAtIndex:0];
    }
    
    EntityItemModel *itemModel = [tableViewPaleo getItemModelByIndexPath:indexPath];
    
    [cell setItemModel:itemModel];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableViewPaleo getNumberOfRowsInSection:section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [tableViewPaleo getSectionCount];
}

-(NSArray *)itemList{
    return itemModelList;
}

@end
