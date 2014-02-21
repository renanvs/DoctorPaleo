//
//  PaleoCoreData.h
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PaleoCoreData : NSObject{
    NSManagedObjectContext *context;
}

@property (nonatomic, assign) NSManagedObjectContext *context;

+ (PaleoCoreData *) sharedInstance;

-(void) flushDatabase;

@end
