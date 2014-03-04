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
    static NSString *cellName = CellFoodItemName;
    
    FoodSubcategoriesCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil]objectAtIndex:0];
    }
    
    FoodItemModel *itemModel = [tableView getFoodModelByIndexPath:indexPath];
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
    [self.navigationItem setTitle:NavNameFavorites];
    
    [self adjustNavigationBarIsEditMode:NO];
    
    tableView.delegateList = self;
    [tableView reloadData];
    
}

-(void)removeAllFavorites{
    
    [[PaleoFoodManager sharedInstance] removeAllFavorites];
    [tableView reloadData];
}

-(NSArray *)foodItemList{
    return [[PaleoFoodManager sharedInstance] favoriteFoodList];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelected) name:TabBarFavoriteSelected object:nil];
}

-(void)tabBarSelected{
    [tableView reloadData];
    [self adjustNavigationBarIsEditMode:NO];
}

-(void)adjustNavigationBarIsEditMode:(BOOL)value{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    
    if (value) {
        UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:@"Apagar Tudo" style:UIBarButtonItemStyleBordered target:self action:@selector(removeAllFavorites)];
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancelar" style:UIBarButtonItemStyleBordered target:self action:@selector(tempHandler1)];
        
        self.navigationItem.rightBarButtonItem = rightButton;
        self.navigationItem.leftBarButtonItem = leftButton;
        
        [tableView setEditing:YES animated:YES];
    }else{
        UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Editar" style:UIBarButtonItemStyleBordered target:self action:@selector(tempHandler)];
        
        self.navigationItem.rightBarButtonItem = rightButton;
        [tableView setEditing:NO animated:YES];
    }
}

-(void)tempHandler{
    [self adjustNavigationBarIsEditMode:YES];
}

-(void)tempHandler1{
    [self adjustNavigationBarIsEditMode:NO];
}

-(void)setEditing:(BOOL)editing animated:(BOOL)animated{
    [super setEditing:editing animated:animated];
    
}

-(void)tableView:(UITableView *)tableView_ commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"sdfsdf");
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView removeItemFromTableViewAtIndex:indexPath];
    }
}

@end
