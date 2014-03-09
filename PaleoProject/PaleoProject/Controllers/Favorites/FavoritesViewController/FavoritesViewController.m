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

#pragma mark - Table implemetation

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

-(void)tableView:(UITableView *)tableView_ commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableView removeItemFromTableViewAtIndex:indexPath];
        [self adjustNavigationBarIsEditMode:NO];
    }
}

//Retorna o DataSource da tabela
-(NSArray *)foodItemList{
    return [[PaleoFoodManager sharedInstance] favoriteFoodList];
}

#pragma mark - Adjust when view did/will appear

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:NavNameFavorites];
    
    [self adjustNavigationBarIsEditMode:NO];
    
    tableView.delegateList = self;
    [tableView reloadData];
    [PaleoGA trackScreen:FavoriteScreen];
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarSelected) name:TabBarFavoriteSelected object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cellSelected:) name:CellFoodItemSelectd object:nil];
}

#pragma mark - selectors

-(void)removeAllFavorites{
    
    [[[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Deseja apagar todos os favoritos?" delegate:self cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil] show];
}

//todo ajustar
-(void)tempHandler{
    [self adjustNavigationBarIsEditMode:YES];
    //gatodo: Botão editar pressionado
}


//todo ajustar
-(void)tempHandler1{
    [self adjustNavigationBarIsEditMode:NO];
}

//Quando o tabBar é selecionando a tabela é recarregada e o modo de edições é desabilitado
-(void)tabBarSelected{
    [tableView reloadData];
    [self adjustNavigationBarIsEditMode:NO];
}

#pragma mark - Adjust method

//Ajusta os botões de edição do NavigationBar
//Isso de acordo com o parametro enviado
-(void)adjustNavigationBarIsEditMode:(BOOL)value{
    self.navigationItem.leftBarButtonItem = nil;
    self.navigationItem.rightBarButtonItem = nil;
    
    //Se não tiver nada no dataSource não é adicionado botões
    if ([self foodItemList].count == 0) {
        return;
    }
    
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

#pragma mark - Notfication's

-(void)cellSelected:(NSNotification*)notification{
    
    
    if ([[PaleoUtils sharedInstance] currentNavigationController] == [self navigationController]) {
        FoodItemModel *foodItemModel = (FoodItemModel*)notification.object;
        //gatodo: model.name model.category from favorites
    }
    
}

#pragma mark - AlertView Delegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[PaleoFoodManager sharedInstance] removeAllFavorites];
        [tableView reloadData];
        [self adjustNavigationBarIsEditMode:NO];
    }
}

@end
