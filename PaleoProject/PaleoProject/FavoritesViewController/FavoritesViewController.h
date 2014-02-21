//
//  FavoritesViewController.h
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaleoItemTableView.h"

@interface FavoritesViewController : UIViewController <UITableViewDataSource, PaleoItemTableViewDelegate>{
    NSArray *typeList;
    NSArray *itemList;
    NSDictionary *dic;
    IBOutlet PaleoItemTableView *tableView;
}

@end
