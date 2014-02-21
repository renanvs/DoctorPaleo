//
//  PaleoSqlite.m
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoSqlite.h"

#import "EntityFoodCategoryModel.h"
#import "EntityItemModel.h"
#import "EntityItemType.h"
#import "PaleoCoreData.h"

@implementation PaleoSqlite

//TODO criar melhor forma de chamar o log

-(void)validateInfo{
    BOOL alreadyRunned = [[NSUserDefaults standardUserDefaults] boolForKey:@"ApplicationAlreadyRunned"];
    
    if (!alreadyRunned) {
        [self createFoodCategories];
        [self createItens];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"ApplicationAlreadyRunned"];
        NSLog(@"Primeira vez que o aplicativo é aberto ou dados resetados");
    }else{
        NSLog(@"Não é criado novo banco");
    }
    
    
}

- (NSMutableArray*) readDataFromDatabase
{
    dataArray  = [[NSMutableArray alloc] init];
    dataStored = [[NSMutableDictionary alloc] init];
    
    NSString *item;
    NSString *type;
    NSString *imageName;
    NSString *about;
    NSString *categoryName;
    NSString *categoryImageName;
    
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"exemplo" withExtension:@"sqlite"];
    NSString *path = [modelURL path];
    
    if (sqlite3_open([path UTF8String], &dataBase) == SQLITE_OK) {
        const char *sql = "SELECT * FROM tabela_exemplo";
        sqlite3_stmt *statement;
        if (sqlite3_prepare_v2(dataBase, sql, -1, &statement, NULL) == SQLITE_OK) {
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                item = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 0)];
                type = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 1)];
                imageName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 2)];
                about = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 3)];
                categoryName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 4)];
                categoryImageName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(statement, 5)];

                
                [dataStored setObject:item forKey:@"item"];
                [dataStored setObject:type forKey:@"type"];
                [dataStored setObject:imageName forKey:@"imageName"];
                [dataStored setObject:about forKey:@"about"];
                [dataStored setObject:categoryName forKey:@"categoryName"];
                [dataStored setObject:categoryImageName forKey:@"categoryImageName"];
                
                
                [dataArray addObject:[dataStored copy]];
            }
        }
        sqlite3_finalize(statement);
    }
    sqlite3_close(dataBase);
    [dataStored release];
    
    return dataArray;
}


-(void)createFoodCategories{
    NSArray *databaseTableResult = [self readDataFromDatabase];
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"categoryName" ascending:YES];
    NSArray *sortDescriptor = [NSArray arrayWithObject:descriptor];
    NSArray *databaseTableResultSorted = [databaseTableResult sortedArrayUsingDescriptors:sortDescriptor];
    
    NSManagedObjectContext *context = [[PaleoCoreData sharedInstance] context];
    
    for (NSDictionary *dic in databaseTableResultSorted) {
        if (![self existCategoryInCoreData:dic]) {
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"EntityFoodCategoryModel" inManagedObjectContext:context];
            EntityFoodCategoryModel *categoryModel = [(EntityFoodCategoryModel*)[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
            categoryModel.name = [dic objectForKey:@"categoryName"];
            categoryModel.imageName = [dic objectForKey:@"categoryImageName"];
            
            NSLog(@"Categoria %@ adicionada ao coredata",categoryModel.name);
        }
    }
}

-(BOOL)existCategoryInCoreData:(NSDictionary*)itemDict{
    NSManagedObjectContext *context = [[PaleoCoreData sharedInstance] context];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EntityFoodCategoryModel" inManagedObjectContext:context];
    NSFetchRequest *request = [[[NSFetchRequest alloc] init]autorelease];
    request.entity = entity;
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@ && imageName == %@",
                         [itemDict objectForKey:@"categoryName"], [itemDict objectForKey:@"categoryImageName"]];
    
    NSArray *result = [context executeFetchRequest:request error:nil];
    
    if (result.count > 0) {
        return YES;
    }
    
    return NO;
}

-(void)createItens{
    NSArray *databaseTableResult = [self readDataFromDatabase];
    
    NSManagedObjectContext *context = [[PaleoCoreData sharedInstance] context];
    
    for (NSDictionary *dic in databaseTableResult) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"EntityItemModel" inManagedObjectContext:context];
        EntityItemModel *itemModel = [(EntityItemModel*)[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        itemModel.name = [dic objectForKey:@"item"];
        itemModel.imageName = [dic objectForKey:@"imageName"];
        itemModel.about = [dic objectForKey:@"about"];
        itemModel.isFavorite = [NSNumber numberWithBool:NO];
        itemModel.type = [self getOrCreateType:([dic objectForKey:@"type"])];
        [self addItem:itemModel ToCoreDataWithCategoryName:[dic objectForKey:@"categoryName"]];
    }
    
    [context save:nil];
    
}

-(void)addItem:(EntityItemModel*)item ToCoreDataWithCategoryName:(NSString*)categoryName{
    NSManagedObjectContext *context = [[PaleoCoreData sharedInstance] context];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EntityFoodCategoryModel" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    request.entity = entity;
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@",categoryName];
    NSArray *result = [context executeFetchRequest:request error:nil];
    
    if (result.count == 0) {
        NSLog(@"Erro: Não existe a categoria: %@", categoryName);
        return;
    }
    
    EntityFoodCategoryModel *categoryModel = [result lastObject];
    [categoryModel addItensObject:item];
    NSLog(@"Item %@, adicionado a categoria %@", item.name, categoryName);
}

-(EntityItemType*)getOrCreateType:(NSString*)typeStr{
    NSManagedObjectContext *context = [[PaleoCoreData sharedInstance] context];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"EntityItemType" inManagedObjectContext:context];
    NSFetchRequest *request= [[NSFetchRequest alloc] init];
    request.entity = entity;
    request.predicate = [NSPredicate predicateWithFormat:@"name == %@", typeStr];
    NSArray *typeList = [context executeFetchRequest:request error:nil];
    
    if (typeList.count > 0) {
        EntityItemType *typeModel = [typeList lastObject];
        NSLog(@"Recuperando tipo: %@", typeModel.name);
        return typeModel;
    }else{
        EntityItemType *typeModel = [(EntityItemType*)[NSManagedObject alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        typeModel.name = typeStr;
        NSLog(@"Inserindo tipo: %@", typeModel.name);
        return typeModel;
    }
    
}

@end
