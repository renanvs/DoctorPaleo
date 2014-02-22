//
//  EntityItemType.h
//  PaleoProject
//
//  Created by renan veloso silva on 22/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FoodItemModel;

@interface FoodTypeModel : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *itens;
@end

@interface FoodTypeModel (CoreDataGeneratedAccessors)

- (void)addItensObject:(FoodItemModel *)value;
- (void)removeItensObject:(FoodItemModel *)value;
- (void)addItens:(NSSet *)values;
- (void)removeItens:(NSSet *)values;

@end
