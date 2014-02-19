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

@interface FoodSubcategoriesViewController ()

@end

@implementation FoodSubcategoriesViewController

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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellName = @"FoodSubcategoriesCell";
    
    FoodSubcategoriesCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    
    if (!cell){
        cell = [[[NSBundle mainBundle] loadNibNamed:cellName owner:self options:nil]objectAtIndex:0];
    }
    
    
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 10;
    }
    
    if (section == 1) {
        return 5;
    }
    
    return 0;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

@end
