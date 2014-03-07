//
//  FoodViewController.h
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodCategoryViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>{
    IBOutlet UITableView *foodTableView;
    CGRect originaRect;
}

@end
