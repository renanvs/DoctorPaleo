//
//  FavoritesViewController.h
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaleoFoodTableView.h"

@interface FavoritesViewController : UIViewController <UITableViewDataSource, PaleoFoodTableViewDelegate, UIAlertViewDelegate>{
    IBOutlet PaleoFoodTableView *tableView;
    BOOL isInEditMode;
}

@end
