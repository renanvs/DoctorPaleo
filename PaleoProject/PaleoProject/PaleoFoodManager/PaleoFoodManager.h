//
//  PaleoFoodManager.h
//  PaleoProject
//
//  Created by renan veloso silva on 19/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaleoCoreData.h"
#import "EntityFoodCategoryModel.h"
#import "EntityItemModel.h"
#import "EntityItemType.h"

@interface PaleoFoodManager : NSObject{
    NSManagedObjectContext *context;
    NSArray *favoriteItens;
    NSArray *categoryList;
    NSArray *allItens;
    NSArray *typeList;
}

@property (nonatomic, assign) NSArray *favoriteItens;
@property (nonatomic, assign) NSArray *categoryList;
@property (nonatomic, assign) NSArray *allItens;
@property (nonatomic, assign) NSArray *typeList;

+ (PaleoFoodManager *) sharedInstance;

-(NSArray *)getItensWithSearchQuery:(NSString*)query;
-(NSArray *)getItensByCategory:(EntityFoodCategoryModel*)categoryModel;
-(NSArray*)getTypeItemListWithItemList:(NSArray*)list;
-(NSDictionary*)getDictionaryWithTypeList:(NSArray*)typeList_ AndItemList:(NSArray*)itemList;

@end
