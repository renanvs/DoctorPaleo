//
//  FoodItemModel.h
//  PaleoProject
//
//  Created by renan veloso silva on 22/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FoodTypeModel, FoodCategoryModel;

@interface FoodItemModel : NSManagedObject

@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) FoodCategoryModel *category;
@property (nonatomic, retain) FoodTypeModel *type;

@end
