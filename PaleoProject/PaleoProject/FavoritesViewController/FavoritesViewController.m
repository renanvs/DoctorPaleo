//
//  FavoritesViewController.m
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FavoritesViewController.h"
#import "FoodSubcategoriesCell.h"

@implementation FavoritesViewController

-(UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"FoodSubcategoriesCell";
    
    FoodSubcategoriesCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil]objectAtIndex:0];
    }
    
    EntityItemModel *itemModel = [tableView getItemModelByIndexPath:indexPath];
    
    [cell setItemModel:itemModel];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView_ numberOfRowsInSection:(NSInteger)section{
    return [tableView getNumberOfRowsInSection:section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView_{
    return [tableView getSectionCount];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:@"Favoritos"];
    tableView.delegateList = self;
    [tableView reloadData];
    
}

-(NSArray *)itemList{
    return [[PaleoFoodManager sharedInstance] favoriteItens];
}

-(void)viewDidAppear:(BOOL)animated{
    NSLog(@"appear");
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelected) name:@"tabBarSelected" object:nil];
}

-(void)tabBarSelected{
    [tableView reloadData];
}

@end
