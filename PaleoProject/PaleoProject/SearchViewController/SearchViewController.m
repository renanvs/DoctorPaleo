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
    tableView.delegateList = self;
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

-(NSArray *)itemList{
    return itemList;
}

- (void)dealloc {
    [searchBar release];
    [super dealloc];
}

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    itemList = [[PaleoFoodManager sharedInstance] getItensWithSearchQuery:searchText];
    [tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:@"Busca"];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar_{
    for (UITextField *field in searchBar_.subviews) {
        [field resignFirstResponder];
    }
    NSLog(@"test");
}


@end
