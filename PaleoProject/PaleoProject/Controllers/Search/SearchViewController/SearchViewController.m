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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidDisappear:) name:UIKeyboardDidHideNotification object:nil];
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
    foodItemList = [[NSArray alloc ]initWithArray: [[PaleoFoodManager sharedInstance] getFoodWithSearchQuery:searchText]];
    [tableView reloadData];
}

-(void)viewDidAppear:(BOOL)animated{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:NavNameSearch];
    [self removeKeyboard];
    [PaleoGA trackScreen:@"SearchScreen"];
}

-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar_{
    [self removeKeyboard];
}

-(void)removeKeyboard{
    for (UITextField *field in searchBar.subviews) {
        [field resignFirstResponder];
    }
}


-(void)keyboardDidShow:(NSNotification*)notification{
    
    
}

-(void)keyboardDidDisappear:(NSNotification*)notification{
    
    
    
}

-(void)keyboardWillDisappear:(NSNotification*)notification{
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGFloat keyboardHeight = keyboardFrameBeginRect.size.height;
    
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    CGFloat tableViewCurrentHeight = tableView.frame.size.height;
    
    CGFloat tableViewNewHeight = tableViewCurrentHeight + keyboardHeight - tabBarHeight;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    tableView.height = tableViewNewHeight;
    [UIView commitAnimations];
}

-(void)keyboardWillShow:(NSNotification*)notification{
    //todo extract method
    NSDictionary* keyboardInfo = [notification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGFloat keyboardHeight = keyboardFrameBeginRect.size.height;
    
    CGFloat tabBarHeight = self.tabBarController.tabBar.frame.size.height;
    CGFloat tableViewCurrentHeight = tableView.frame.size.height;
    
    CGFloat tableViewNewHeight = tableViewCurrentHeight + tabBarHeight - keyboardHeight;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    tableView.height = tableViewNewHeight;
    [UIView commitAnimations];

}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self removeKeyboard];
}

@end
