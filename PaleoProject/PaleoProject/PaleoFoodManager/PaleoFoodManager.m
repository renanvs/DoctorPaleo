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

#pragma mark - initial method's

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

#pragma mark - get method's

//Pega a lista de Categorias do banco
-(NSArray *)getCategoryList{
    NSEntityDescription *entity = [NSEntityDescription entityForName:EntityCategory inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    
    NSArray *list = [context executeFetchRequest:request error:nil];
    
    return list;
}

//Pega a lista de FoodItemModel no banco com base na Categoria
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

//Pega a lista de FoodItemModel no banco que seja favoritado
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

//Pega a lista de FoodItemModel no banco com base numa string
//Essa string é comparada com o nome do FoodItemModel, e se tiver alguma ocorrencia dessa string
//no nome do FoodItemModel, então é inserida na lista de encontrados
//obs.: se for digitado "*" então retorna todos os itens
-(NSArray *)getFoodWithSearchQuery:(NSString*)query{
    if ([query isEqualToString:@"*"]) {
        return [self getAllFoodItens];
    }
    
    query = [[Utils sharedInstance] getSafeLiteralString:query];
    
    NSMutableArray *foundedItens = [[NSMutableArray alloc] init];
    NSRange range;
    
    NSArray *list = [self getAllFoodItens];
    
    for (FoodItemModel *foodItem in list) {
        NSString *foodName = [[Utils sharedInstance] getSafeLiteralString:foodItem.name];
        range = [foodName rangeOfString:query];
        
        if (range.length > 0) {
            [foundedItens addObject:foodItem];
        }
    }
    
    return foundedItens;
}

//Pega todos os fooditemModel do banco
-(NSArray *)getAllFoodItens{
    NSEntityDescription *entity = [NSEntityDescription entityForName:EntityFood inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    NSArray *list = [context executeFetchRequest:request error:nil];
    return list;
}

//Retona a lista de FoodTypeModel com base na lista de FoodItemModel
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

//Pega a lista de FoodTypeModel no banco
-(NSArray *)getTypeList{
    NSEntityDescription *entity = [NSEntityDescription entityForName:EntityType inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    request.sortDescriptors = [NSArray arrayWithObject:descriptor];
    
    NSArray *list = [context executeFetchRequest:request error:nil];
    
    return list;
}

//Pega o dicionario (que contem como chave o foodType.name e o objeto é um array com a lista de edições desse foodType),
//com base na lista de FoodTypeModel e a lista de FoodItemModel
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

#pragma mark - auxiliar method's

//Setter da lista de favoritos
-(NSArray *)favoriteFoodList{
    return [self getFavoriteFoodList];
}

//Procura o FoodItemModel com base no NSIndexPath e da lista de FoodItemModel
-(FoodItemModel*)findFoodItemByIndex:(NSIndexPath*)index AtList:(NSArray*)list{
    NSArray *type = [self getFoodTypeListWithFoodList:list];
    NSDictionary *dic = [self getDictionaryWithFoodTypeList:type AndFoodList:list];
    NSString *keyDesire = [[dic allKeys] objectAtIndex:index.section];
    FoodItemModel *currentFood = [[dic objectForKey:keyDesire] lastObject];
    
    return currentFood;
}

#pragma mark - remove method's

//Muda os status de favoritado para NO (false) em todos os FoodItemModel do banco
-(void)removeAllFavorites{
    NSArray *favoriteList = [self favoriteFoodList];
    for (FoodItemModel *foodItem in favoriteList) {
        foodItem.isFavorite = [NSNumber numberWithBool:NO];
    }
    
    [context save:nil];
}

//Muda os status de favoritado para NO (false) no foodItem
-(void)removeItemFromFavorites:(FoodItemModel*)foodItem{
    foodItem.isFavorite = [NSNumber numberWithBool:NO];
    [context save:nil];
}

@end
