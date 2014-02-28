//
//  SearchViewController.h
//  PaleoProject
//
//  Created by renan veloso silva on 17/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaleoFoodTableView.h"

@interface SearchViewController : UIViewController <UITableViewDataSource, PaleoFoodTableViewDelegate, UISearchBarDelegate>{
    NSArray *foodItemList;
    IBOutlet PaleoFoodTableView *tableView;
    IBOutlet UISearchBar *searchBar;
}

@end
