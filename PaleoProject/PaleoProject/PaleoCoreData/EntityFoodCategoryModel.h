//
//  EntityFoodCategoryModel.h
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EntityItemModel;

@interface EntityFoodCategoryModel : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * imageName;
@property (nonatomic, retain) NSSet *itens;
@end

@interface EntityFoodCategoryModel (CoreDataGeneratedAccessors)

- (void)addItensObject:(EntityItemModel *)value;
- (void)removeItensObject:(EntityItemModel *)value;
- (void)addItens:(NSSet *)values;
- (void)removeItens:(NSSet *)values;

@end
