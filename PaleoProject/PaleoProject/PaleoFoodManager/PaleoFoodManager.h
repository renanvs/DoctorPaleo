//
//  PaleoFoodManager.h
//  PaleoProject
//
//  Created by renan veloso silva on 19/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaleoCoreData.h"
#import "FoodCategoryModel.h"
#import "FoodItemModel.h"
#import "FoodTypeModel.h"

@interface PaleoFoodManager : NSObject{
    NSManagedObjectContext *context;
    NSArray *favoriteFoodList;
    NSArray *categoryList;
    NSArray *typeList;
}

@property (nonatomic, assign) NSArray *favoriteFoodList;
@property (nonatomic, assign) NSArray *categoryList;
@property (nonatomic, assign) NSArray *typeList;

+ (PaleoFoodManager *) sharedInstance;

-(NSArray *)getFoodWithSearchQuery:(NSString*)query;
-(NSArray *)getFoodListByCategory:(FoodCategoryModel*)categoryModel;
-(NSArray*)getFoodTypeListWithFoodList:(NSArray*)list;
-(NSDictionary*)getDictionaryWithFoodTypeList:(NSArray*)typeList_ AndFoodList:(NSArray*)foodList;

@end
