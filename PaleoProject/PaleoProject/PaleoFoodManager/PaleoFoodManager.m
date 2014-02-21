//
//  PaleoFoodManager.m
//  PaleoProject
//
//  Created by renan veloso silva on 19/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoFoodManager.h"

@implementation PaleoFoodManager
@synthesize allItens, categoryList, favoriteItens, typeList;

static id _instance;
+ (PaleoFoodManager *) sharedInstance{
    @synchronized(self){
        if (!_instance) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}

-(id)init{
    self = [super init];
    
    if (self) {
        context = [[PaleoCoreData sharedInstance] context];
        //favoriteItens = [[NSArray alloc] initWithArray:[self getFavoriteItens]];
        categoryList = [[NSArray alloc] initWithArray:[self getCategoryList]];
        allItens = [[NSArray alloc] initWithArray:[self getAllItens]];
        typeList = [[NSArray alloc] initWithArray:[self getTypeList]];
    }
    
    return self;
}

-(NSArray *)getCategoryList{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EntityFoodCategoryModel" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    
    NSArray *list = [context executeFetchRequest:request error:nil];
    
    return list;
}

-(NSArray *)getItensByCategory:(EntityFoodCategoryModel*)categoryModel{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EntityItemModel" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    //TODO: ordernar por ordem do tip
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"type" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    request.predicate = [NSPredicate predicateWithFormat:@"category == %@",categoryModel];
    
    NSArray *list = [context executeFetchRequest:request error:nil];
    
    return list;
}

-(NSArray *)getFavoriteItens{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EntityItemModel" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    request.predicate = [NSPredicate predicateWithFormat:@"isFavorite == %@", [NSNumber numberWithBool:YES]];
    
    NSArray *list = [context executeFetchRequest:request error:nil];
    
    return list;
}

-(NSArray *)getItensWithSearchQuery:(NSString*)query{
    query = [query lowercaseString];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EntityItemModel" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    NSArray *list = [context executeFetchRequest:request error:nil];
    
    NSMutableArray *foundedItens = [[NSMutableArray alloc] init];
    NSRange range;
    
    for (EntityItemModel *item in list) {
        NSString *itemName = [item.name lowercaseString];
        range = [itemName rangeOfString:query];
        
        if (range.length > 0) {
            [foundedItens addObject:item];
        }
    }
    
    return foundedItens;
}


-(NSArray *)getAllItens{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EntityItemModel" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"type.name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    
    NSArray *list = [context executeFetchRequest:request error:nil];
    
    return list;
}

-(NSArray *)getTypeList{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EntityItemType" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    
    NSArray *list = [context executeFetchRequest:request error:nil];
    
    return list;
}

-(NSArray*)getTypeItemListWithItemList:(NSArray*)list{
    NSMutableArray *typesFounded = [[NSMutableArray alloc] init];
    
    for (EntityItemType *type in typeList) {
        for (EntityItemModel *item in list) {
            if (type == item.type) {
                [typesFounded addObject:type];
                break;
            }
        }
    }
    return typesFounded;
}

-(NSDictionary*)getDictionaryWithTypeList:(NSArray*)typeList_ AndItemList:(NSArray*)itemList{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSMutableArray *add = nil;
    
    for (EntityItemType *type in typeList_) {
        add = [[NSMutableArray alloc] init];
        for (EntityItemModel *item in itemList) {
            if (item.type == type) {
                [add addObject:item];
            }
        }
        [dic setObject:add forKey:type.name];
        [add release];
        add = nil;
    }
    
    return dic;
}

-(NSArray *)favoriteItens{
    return [self getFavoriteItens];
}

@end
