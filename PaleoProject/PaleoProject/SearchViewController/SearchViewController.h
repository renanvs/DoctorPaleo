//
//  SearchViewController.h
//  PaleoProject
//
//  Created by renan veloso silva on 17/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaleoItemTableView.h"

@interface SearchViewController : UIViewController <UITableViewDataSource, PaleoItemTableViewDelegate, UISearchBarDelegate>{
    NSArray *itemList;
    IBOutlet PaleoItemTableView *tableView;
    IBOutlet UISearchBar *searchBar;
}

@end
