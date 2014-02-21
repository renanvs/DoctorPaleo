//
//  SearchViewController.m
//  PaleoProject
//
//  Created by renan veloso silva on 17/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "SearchViewController.h"
#import "FoodSubcategoriesCell.h"

@interface SearchViewController ()

@end

@implementation SearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    dic = [[NSDictionary alloc] init];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UITableViewCell *)tableView:(UITableView *)tableView_ cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"FoodSubcategoriesCell";
    
    FoodSubcategoriesCell * cell = [tableView_ dequeueReusableCellWithIdentifier:cellName];
    
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

-(NSArray *)itemList{
    return itemList;
}

- (void)dealloc {
    [searchBar release];
    [super dealloc];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    itemList = [[PaleoFoodManager sharedInstance] getItensWithSearchQuery:searchText];
    typeList = [[PaleoFoodManager sharedInstance] getTypeItemListWithItemList:itemList];
    dic = [[PaleoFoodManager sharedInstance] getDictionaryWithTypeList:typeList AndItemList:itemList];
    [tableView reloadData];
}

@end
