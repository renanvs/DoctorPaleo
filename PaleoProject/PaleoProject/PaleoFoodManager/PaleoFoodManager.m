//
//  PaleoFoodManager.m
//  PaleoProject
//
//  Created by renan veloso silva on 19/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoFoodManager.h"

@implementation PaleoFoodManager
@synthesize categoryList, favoriteFoodList, typeList;

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
        categoryList = [[NSArray alloc] initWithArray:[self getCategoryList]];
        typeList = [[NSArray alloc] initWithArray:[self getTypeList]];
    }
    
    return self;
}

-(NSArray *)getCategoryList{
    NSEntityDescription *entity = [NSEntityDescription entityForName:EntityCategory inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    
    NSArray *list = [context executeFetchRequest:request error:nil];
    
    return list;
}

-(NSArray *)getFoodListByCategory:(FoodCategoryModel*)categoryModel{
    NSEntityDescription *entity = [NSEntityDescription entityForName:EntityFood inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"type.name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    request.predicate = [NSPredicate predicateWithFormat:@"category == %@",categoryModel];
    
    NSArray *list = [context executeFetchRequest:request error:nil];
    
    return list;
}

-(NSArray *)getFavoriteFoodList{
    NSEntityDescription *entity = [NSEntityDescription entityForName:EntityFood inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    request.predicate = [NSPredicate predicateWithFormat:@"isFavorite == %@", [NSNumber numberWithBool:YES]];
    
    NSArray *list = [context executeFetchRequest:request error:nil];
    
    return list;
}

-(NSArray *)getFoodWithSearchQuery:(NSString*)query{
    query = [[Utils sharedInstance] getSafeLiteralString:query];
    NSEntityDescription *entity = [NSEntityDescription entityForName:EntityFood inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    NSArray *list = [context executeFetchRequest:request error:nil];
    
    NSMutableArray *foundedItens = [[NSMutableArray alloc] init];
    NSRange range;
    
    for (FoodItemModel *foodItem in list) {
        NSString *foodName = [[Utils sharedInstance] getSafeLiteralString:foodItem.name];
        range = [foodName rangeOfString:query];
        
        if (range.length > 0) {
            [foundedItens addObject:foodItem];
        }
    }
    
    return foundedItens;
}

-(NSArray *)getTypeList{
    NSEntityDescription *entity = [NSEntityDescription entityForName:EntityType inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    
    NSArray *list = [context executeFetchRequest:request error:nil];
    
    return list;
}

-(NSArray*)getFoodTypeListWithFoodList:(NSArray*)list{
    NSMutableArray *typesFounded = [[NSMutableArray alloc] init];
    
    for (FoodTypeModel *foodType in typeList) {
        for (FoodItemModel *foodItem in list) {
            if (foodType == foodItem.type) {
                [typesFounded addObject:foodType];
                break;
            }
        }
    }
    return typesFounded;
}

-(NSDictionary*)getDictionaryWithFoodTypeList:(NSArray*)typeList_ AndFoodList:(NSArray*)foodList{
    NSMutableDictionary *categoryDictionary = [[NSMutableDictionary alloc] init];
    NSMutableArray *tempFoodList = nil;
    
    for (FoodTypeModel *foodType in typeList_) {
        tempFoodList = [[NSMutableArray alloc] init];
        for (FoodItemModel *foodItem in foodList) {
            if (foodItem.type == foodType) {
                [tempFoodList addObject:foodItem];
            }
        }
        [categoryDictionary setObject:tempFoodList forKey:foodType.name];
        [tempFoodList release];
        tempFoodList = nil;
    }
    
    return categoryDictionary;
}

-(NSArray *)favoriteFoodList{
    return [self getFavoriteFoodList];
}

@end
