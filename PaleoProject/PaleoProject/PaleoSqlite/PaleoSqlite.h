//
//  PaleoSqlite.h
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface PaleoSqlite : NSObject{
    sqlite3 *dataBase;
    NSManagedObjectContext *context;
}

-(void)validateInfo;

@end
