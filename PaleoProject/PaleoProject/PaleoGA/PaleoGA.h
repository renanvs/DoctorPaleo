//
//  PaleoGA.h
//  PaleoProject
//
//  Created by renan veloso silva on 04/03/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GAI.h"

#define FavoriteScreen              @"FavoriteScreen"
#define FoodItemScreen              @"FoodItemScreen"
#define SearchScreen                @"SearchScreen"
#define FoodSubcategoriesScreen     @"FoodSubcategoriesScreen"
#define FoodCategoryScreen          @"FoodCategoryScreen"
#define SettingsScreen              @"SettingsScreen"

@interface PaleoGA : NSObject

+ (PaleoGA *) sharedInstance;

-(void)setTrackId:(NSString*)trackingId;
+(void)trackScreen:(NSString*)screenName;

@end
