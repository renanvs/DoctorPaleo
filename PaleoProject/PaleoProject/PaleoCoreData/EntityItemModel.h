//
//  EntityItemModel.h
//  PaleoProject
//
//  Created by renan veloso silva on 20/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EntityFoodCategoryModel, EntityItemType;

@interface EntityItemModel : NSManagedObject

@property (nonatomic, retain) NSString * about;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSNumber * isFavorite;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) EntityFoodCategoryModel *category;
@property (nonatomic, retain) EntityItemType *type;

@end