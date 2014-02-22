//
//  SearchViewController.m
//  PaleoProject
//
//  Created by renan veloso silva on 17/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "SearchViewController.h"
#import "FoodSubcategoriesCell.h"

@implementation SearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    tableView.delegateList = self;
}

-(UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = CellFoodItemName;
    
    FoodSubcategoriesCell * cell = [tableView_ dequeueReusableCellWithIdentifier:cellName];
    if (!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil]objectAtIndex:0];
    }
    
    FoodItemModel *foodModel = [tableView getFoodModelByIndexPath:indexPath];
    [cell setItemModel:foodModel];
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView_ numberOfRowsInSection:(NSInteger)section{
    return [tableView getNumberOfRowsInSection:section];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView_{
    return [tableView getSectionCount];
}

-(NSArray *)foodItemList{
    return foodItemList;
}

- (void)dealloc {
    [searchBar release];
    [super dealloc];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    foodItemList = [[PaleoFoodManager sharedInstance] getFoodWithSearchQuery:searchText];
    [tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:NavNameSearch];
    [self removeKeyboard];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar_{
    [self removeKeyboard];
}

-(void)removeKeyboard{
    for (UITextField *field in searchBar.subviews) {
        [field resignFirstResponder];
    }
}


@end
