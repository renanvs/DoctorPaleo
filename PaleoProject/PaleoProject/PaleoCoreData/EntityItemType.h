//
//  EntityItemType.h
//  PaleoProject
//
//  Created by renan veloso silva on 20/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class EntityItemModel;

@interface EntityItemType : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *itens;
@end

@interface EntityItemType (CoreDataGeneratedAccessors)

- (void)addItensObject:(EntityItemModel *)value;
- (void)removeItensObject:(EntityItemModel *)value;
- (void)addItens:(NSSet *)values;
- (void)removeItens:(NSSet *)values;

@end
