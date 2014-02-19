//
//  PeleoTabBarController.m
//  PaleoProject
//
//  Created by renan veloso silva on 17/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoTabBarController.h"
#import "FoodCategoryViewController.h"
#import "SearchViewController.h"
#import "FavoritesViewController.h"
#import "SettingsViewController.h"
#import "PaleoNavigationController.h"

@interface PaleoTabBarController ()

@end

@implementation PaleoTabBarController

- (void)viewDidLoad
{
    [super viewDidLoad];
    float iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    if (iOSVersion >= 7) {
        self.tabBar.translucent = NO;
    }
    
	// Do any additional setup after loading the view.
}

-(id)init{
    self = [super init];
    if (self) {
        [self addViewControllers];
    }
    return self;
}

-(void)addViewControllers{
    PaleoNavigationController *foodNavigationController = [self createFoodCategoryController];
    PaleoNavigationController *searchNavigationController = [self createSearchItemController];
    PaleoNavigationController *favoriteNavigationController = [self createFavoriteItemController];
    PaleoNavigationController *settingsNavigationController = [self createSettingsController];
    
    self.viewControllers = [NSArray arrayWithObjects:foodNavigationController, searchNavigationController, favoriteNavigationController, settingsNavigationController,nil];
}

-(PaleoNavigationController*)createFoodCategoryController{
    FoodCategoryViewController *foodCategoryViewController = [[FoodCategoryViewController alloc] init];
    PaleoNavigationController *paleoNavigationController = [[PaleoNavigationController alloc] initWithRootViewController:foodCategoryViewController];
    return paleoNavigationController;
}

-(PaleoNavigationController*)createSearchItemController{
    SearchViewController *searchViewController = [[SearchViewController alloc] init];
    PaleoNavigationController *paleoNavigationController = [[PaleoNavigationController alloc] initWithRootViewController:searchViewController];
    return paleoNavigationController;
}

-(PaleoNavigationController*)createFavoriteItemController{
    FavoritesViewController *favoritesViewController = [[FavoritesViewController alloc] init];
    PaleoNavigationController *paleoNavigationController = [[PaleoNavigationController alloc] initWithRootViewController:favoritesViewController];
    return paleoNavigationController;
}

-(PaleoNavigationController*)createSettingsController{
    SettingsViewController *settingsViewController = [[SettingsViewController alloc] init];
    PaleoNavigationController *paleoNavigationController = [[PaleoNavigationController alloc] initWithRootViewController:settingsViewController];
    return paleoNavigationController;
}


@end
