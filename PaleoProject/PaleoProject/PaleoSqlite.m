//
//  PaleoSqlite.m
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoSqlite.h"

@implementation PaleoSqlite

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
        const char *sql = "SELECT * FROM tabela_exemplo2";
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

@end
