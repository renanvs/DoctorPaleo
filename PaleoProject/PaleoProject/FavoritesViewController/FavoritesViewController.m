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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

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
    tableView.delegateList = self;
    [self createObjects];
}

-(NSArray *)itemList{
    return itemList;
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
