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
//Método que retorna a lista de alimentos
//É altamente necessario para gerenciar os alimentos por seção, entre outros tratamentos que podem ser visto na implemtação (.m)
-(NSArray*)foodItemList;

@end

@interface PaleoFoodTableView : UITableView <UITableViewDelegate>{
    id <PaleoFoodTableViewDelegate> delegateList;
    NSArray *foodList;
}

@property (nonatomic, assign) id <PaleoFoodTableViewDelegate> delegateList;

/**
 Check whether a file at a given URL has a newer timestamp than a given file.
 Example usage:
 @code
 NSURL *url1, *url2;
 BOOL isNewer = [FileUtils
 isThisFileNewerThanThatFile:url1 thatURL:url2];
 @endcode
 @see http://www.dadabeatnik.com for more information.
 @param indexPath
 The URL of the source file.
 @return YES if the timestamp of @c thatURL is newer than the timestamp of @c thisURL,
 otherwise NO.
 */
-(FoodItemModel*)getFoodModelByIndexPath:(NSIndexPath*)indexPath;
-(NSInteger)getNumberOfRowsInSection:(NSInteger)section;
-(NSInteger)getSectionCount;
-(void)removeItemFromTableViewAtIndex:(NSIndexPath*)index;

@end
