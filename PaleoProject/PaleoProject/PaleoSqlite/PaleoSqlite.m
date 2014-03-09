//
//  PaleoSqlite.m
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoSqlite.h"
#import "FoodCategoryModel.h"
#import "FoodItemModel.h"
#import "FoodTypeModel.h"
#import "PaleoCoreData.h"

@implementation PaleoSqlite

#pragma mark - Validate Info

//Método que valida se o aplicativo já foi aberto pelo menos uma vez,
//caso não, cria o coreData com base no SQLite e grava no UserDefaults que o app já foi aberto
-(void)validateInfo{
    BOOL alreadyRunned = [[NSUserDefaults standardUserDefaults] boolForKey:@"ApplicationAlreadyRunned"];
    
    if (!alreadyRunned) {
        context = [[PaleoCoreData sharedInstance] context];
        [self createFoodCategories];
        [self createFoodItemModels];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ApplicationAlreadyRunned"];
        [context save:nil];
        NSLog(@"Primeira vez que o aplicativo é aberto ou dados resetados");
        //gatodo: primeira vez que aplicativo abre
    }else{
        //gatodo: aplicativo aberto
        NSLog(@"Não é criado novo banco");
    }
}

#pragma mark - Extract SQLite

//retorna a lista com dicionarios, que são os itens que serão separados por models do CoreData
- (NSMutableArray*) readDataFromDatabase
{
    NSString *foodName;
    NSString *typeName;
    NSString *foodImageName;
    NSString *foodAbout;
    NSString *categoryName;
    NSString *categoryImageName;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"exemplo" withExtension:@"sqlite"];
    NSString *path = [modelURL path];
    NSMutableArray *itemDataList = [[NSMutableArray alloc] init];
    
    if (sqlite3_open([path UTF8String], &dataBase) == SQLITE_OK) {
        const char *sql = "SELECT * FROM tabela_exemplo";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(dataBase, sql, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                foodName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                typeName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                foodImageName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                foodAbout = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                categoryName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                categoryImageName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];

                NSMutableDictionary *itemData = [[NSMutableDictionary alloc] init];
                [itemData setObject:foodName forKey:@"foodName"];
                [itemData setObject:typeName forKey:@"foodTypeName"];
                [itemData setObject:foodImageName forKey:@"foodImageName"];
                [itemData setObject:foodAbout forKey:@"foodAbout"];
                [itemData setObject:categoryName forKey:@"categoryName"];
                [itemData setObject:categoryImageName forKey:@"categoryImageName"];
                
                
                [itemDataList addObject:[itemData copy]];
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(dataBase);
    
    return itemDataList;
}

#pragma mark - Extract to Model's

//Cria os FoodCategoryModel's
-(void)createFoodCategories{
    NSArray *databaseTableResult = [self readDataFromDatabase];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"categoryName" ascending:YES];
    NSArray *sortDescriptor = [NSArray arrayWithObject:descriptor];
    NSArray *databaseTableResultSorted = [databaseTableResult sortedArrayUsingDescriptors:sortDescriptor];
    
    for (NSDictionary *itemData in databaseTableResultSorted) {
        if (![self existCategoryInCoreData:itemData]) {
            NSEntityDescription *entity = [NSEntityDescription entityForName:EntityCategory inManagedObjectContext:context];
            FoodCategoryModel *categoryModel = [(FoodCategoryModel*)[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            categoryModel.name = [itemData objectForKey:@"categoryName"];
            categoryModel.imageName = [itemData objectForKey:@"categoryImageName"];
            
            NSLog(@"Categoria %@ adicionada ao coredata",categoryModel.name);
        }
    }
}

//Verifica se já existe uma categoria igual no CoreData
-(BOOL)existCategoryInCoreData:(NSDictionary*)itemData{
    NSEntityDescription *entity = [NSEntityDescription entityForName:EntityCategory inManagedObjectContext:context];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init]autorelease];
    request.entity = entity;
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@ && imageName == %@",
                         [itemData objectForKey:@"categoryName"], [itemData objectForKey:@"categoryImageName"]];
    
    NSArray *result = [context executeFetchRequest:request error:nil];
    
    if (result.count > 0) {
        return YES;
    }
    
    return NO;
}

//Cria os FoodItemModel's
-(void)createFoodItemModels{
    NSArray *databaseTableResult = [self readDataFromDatabase];
    
    for (NSDictionary *itemData in databaseTableResult) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:EntityFood inManagedObjectContext:context];
        FoodItemModel *itemModel = [(FoodItemModel*)[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        itemModel.name = [itemData objectForKey:@"foodName"];
        itemModel.imageName = [itemData objectForKey:@"foodImageName"];
        itemModel.about = [itemData objectForKey:@"foodAbout"];
        itemModel.isFavorite = [NSNumber numberWithBool:NO];
        itemModel.type = [self getOrCreateFoodType:([itemData objectForKey:@"foodTypeName"])];
        [self addFoodItem:itemModel ToCoreDataWithCategoryName:[itemData objectForKey:@"categoryName"]];
    }
}

//Adiciona o FoodItemModel com base no nome da categoria
-(void)addFoodItem:(FoodItemModel*)foodItem ToCoreDataWithCategoryName:(NSString*)categoryName{
    NSEntityDescription *entity = [NSEntityDescription entityForName:EntityCategory inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@",categoryName];
    NSArray *result = [context executeFetchRequest:request error:nil];
    
    if (result.count == 0) {
        NSLog(@"Erro: Não existe a categoria: %@", categoryName);
        return;
    }
    
    FoodCategoryModel *categoryModel = [result lastObject];
    [categoryModel addItensObject:foodItem];
    NSLog(@"Item %@, adicionado a categoria %@", foodItem.name, categoryName);
}

//Pega ou cria um novo FoodTypeModel com base no nome do tipo
-(FoodTypeModel*)getOrCreateFoodType:(NSString*)typeName{
    NSEntityDescription *entity = [NSEntityDescription entityForName:EntityType inManagedObjectContext:context];
    NSFetchRequest *request= [[NSFetchRequest alloc] init];
    request.entity = entity;
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@", typeName];
    NSArray *typeList = [context executeFetchRequest:request error:nil];
    
    if (typeList.count > 0) {
        FoodTypeModel *typeModel = [typeList lastObject];
        NSLog(@"Recuperado tipo: %@", typeModel.name);
        return typeModel;
    }else{
        FoodTypeModel *typeModel = [(FoodTypeModel*)[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        typeModel.name = typeName;
        NSLog(@"Inserindo tipo: %@", typeModel.name);
        return typeModel;
    }
}

@end
