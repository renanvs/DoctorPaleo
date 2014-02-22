//
//  FoodSubcategoriesViewController.h
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaleoItemTableView.h"

@interface FoodSubcategoriesViewController : UIViewController <UITableViewDataSource, PaleoItemTableViewDelegate>{
    NSArray *itemModelList;
    IBOutlet PaleoItemTableView *tableViewPaleo;
}

- (id)initWithItemList:(NSArray*)itemList;

@end
