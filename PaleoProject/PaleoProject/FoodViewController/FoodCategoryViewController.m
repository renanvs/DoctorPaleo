//
//  FoodViewController.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FoodCategoryViewController.h"
#import "FoodCategoryCell.h"
#import "FoodSubcategoriesViewController.h"

@interface FoodCategoryViewController ()

@end

@implementation FoodCategoryViewController

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

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:@"Title"];
    foodTableView.sectionHeaderHeight = 0;
    foodTableView.sectionFooterHeight = 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"FoodCategoryCell";
    
    FoodCategoryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil]objectAtIndex:0];
    }
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodSubcategoriesViewController *foodSubcategoryViewContoller = [[FoodSubcategoriesViewController alloc] init];
    [self.navigationController pushViewController:foodSubcategoryViewContoller animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

@end
