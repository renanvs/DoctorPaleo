//
//  PaleoItemTableView.h
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaleoFoodTableViewDelegate <NSObject>

@required
-(NSArray*)foodItemList;

@end

@interface PaleoFoodTableView : UITableView <UITableViewDelegate>{
    id <PaleoFoodTableViewDelegate> delegateList;
    NSArray *foodList;
}

@property (nonatomic, assign) id <PaleoFoodTableViewDelegate> delegateList;

-(FoodItemModel*)getFoodModelByIndexPath:(NSIndexPath*)indexPath;
-(NSInteger)getNumberOfRowsInSection:(NSInteger)section;
-(NSInteger)getSectionCount;
-(void)removeItemFromTableViewAtIndex:(NSIndexPath*)index;

@end
