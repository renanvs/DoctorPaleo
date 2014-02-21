//
//  PaleoCoreData.m
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoCoreData.h"
#import "PaleoSqlite.h"

@implementation PaleoCoreData
@synthesize context;

static id _instance;
+ (PaleoCoreData *) sharedInstance{
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

    }
    return self;
}

-(void)saveContext{
    NSError *error;
    if (![context save:&error]) {
        NSDictionary *informacoes = [error userInfo];
        NSArray *multiplosError = [informacoes objectForKey:NSDetailedErrorsKey];
        if (multiplosError) {
            for (NSError *error in multiplosError) {
                NSLog(@"Problema: %@", [error userInfo]);
            }
        }else{
            NSLog(@"Problema: %@", informacoes);
        }
    }else{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"CoreDataSave" object:nil];
    }
}

-(NSManagedObjectModel*)managedObjectModel{
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"PaleoDataModel" withExtension:@"momd"];
    NSManagedObjectModel *managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return managedObjectModel;
}

-(NSPersistentStoreCoordinator *)coordinator{
    NSPersistentStoreCoordinator *coordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    
    NSURL *pastaDocuments = [self applicationDocumentsDirectory];
    NSURL *localBancoDados = [pastaDocuments URLByAppendingPathComponent:@"PaleoDatabase.sqlite"];
    
    [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:localBancoDados options:nil error:nil];
    return coordinator;
}

-(NSURL*)applicationDocumentsDirectory{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

-(NSManagedObjectContext *)context{
    if (context != nil) {
        return context;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self coordinator];
    context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:coordinator];
    return context;
}

-(void) flushDatabase{
    [context lock];
    
    NSManagedObjectModel *model = [self managedObjectModel];
    NSPersistentStoreCoordinator *coordinator = [self coordinator];
    NSArray *stores = [coordinator persistentStores];
    for(NSPersistentStore *store in stores) {
        [coordinator removePersistentStore:store error:nil];
        [[NSFileManager defaultManager] removeItemAtPath:store.URL.path error:nil];
    }
    [context unlock];
    
    model   = nil;
    context  = nil;
    coordinator = nil;
}


@end
