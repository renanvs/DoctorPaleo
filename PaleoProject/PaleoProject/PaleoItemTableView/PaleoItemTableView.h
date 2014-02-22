//
//  PaleoItemTableView.h
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PaleoItemTableViewDelegate <NSObject>

@required
-(NSArray*)itemList;

@end

@interface PaleoItemTableView : UITableView <UITableViewDelegate>{
    id <PaleoItemTableViewDelegate> delegateList;
    NSArray *itemList;
}

@property (nonatomic, assign) id <PaleoItemTableViewDelegate> delegateList;

-(EntityItemModel*)getItemModelByIndexPath:(NSIndexPath*)indexPath;
-(int)getNumberOfRowsInSection:(int)section;
-(int)getSectionCount;

@end
