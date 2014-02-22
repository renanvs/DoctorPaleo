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
        self.delegate = self;
        [self addViewControllers];
        [self addIcons];
    }
    return self;
}

-(void)addViewControllers{
    categoriesPaleoNavigationController = [self createFoodCategoryController];
    searchPaleoNavigationController = [self createSearchItemController];
    favoritesPaleoNavigationController = [self createFavoriteItemController];
    settingsPaleoNavigationController = [self createSettingsController];
    
    self.viewControllers = [NSArray arrayWithObjects:categoriesPaleoNavigationController, searchPaleoNavigationController, favoritesPaleoNavigationController, settingsPaleoNavigationController,nil];
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

-(void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    PaleoNavigationController *navCont = (PaleoNavigationController*)viewController;
    if (navCont == favoritesPaleoNavigationController) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"tabBarSelected" object:nil];
    }
}

-(void)addIcons{
    NSArray *itens = self.tabBar.items;
    NSArray *itemImage = [NSArray arrayWithObjects:@"Food", @"Search", @"Favorites", @"Settings", nil];
    NSArray *itemLabel = [NSArray arrayWithObjects:@"Alimentos", @"Busca", @"Favoritos", @"Ajustes", nil];
    
    for (UITabBarItem *tabItem in itens) {
        [tabItem setImage:[UIImage imageNamed:[NSString stringWithFormat:@"tabBarItem%@.png",[itemImage objectAtIndex:[itens indexOfObject:tabItem]]]]];
        [tabItem setTitle:[itemLabel objectAtIndex:[itens indexOfObject:tabItem]]];
    }
    NSLog(@"itens");
}

@end
