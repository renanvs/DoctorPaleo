//
//  Utils.m
//  PaleoProject
//
//  Created by renan veloso silva on 22/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "Utils.h"

@implementation Utils

static id _instance;
+ (Utils *) sharedInstance{
    @synchronized(self){
        if (!_instance) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}

-(NSString*)getSafeLiteralString:(NSString*)text{
    NSDictionary *typeA= [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:@"ã", @"â", @"á", @"à", nil] forKey:@"a"];
    NSDictionary *typeE= [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:@"é", @"ê", @"è", nil] forKey:@"e"];
    NSDictionary *typeI= [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:@"í", @"î", @"ì", nil] forKey:@"i"];
    NSDictionary *typeO= [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:@"ó", @"ô", @"ò", @"õ", nil] forKey:@"o"];
    NSDictionary *typeU= [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:@"ú", @"û", @"ù", nil] forKey:@"u"];
    NSDictionary *typeC= [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:@"ç", nil] forKey:@"c"];
    NSArray *listType = [NSArray arrayWithObjects:typeA, typeE, typeI, typeO, typeU, typeC, nil];
    
    text = [text lowercaseString];
    for (NSDictionary *dic in listType) {
        NSString *key = [[dic allKeys] lastObject];
        NSArray *array = [dic objectForKey:key];
        for (NSString *charValue in array) {
            NSRange range = [text rangeOfString:charValue];
            if (range.length > 0) {
                text = [text stringByReplacingOccurrencesOfString:charValue withString:key];
            }
            
        }
    }
    
    return text;
    
}

@end
