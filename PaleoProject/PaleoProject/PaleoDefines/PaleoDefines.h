//
//  PaleoDefines.h
//  PaleoProject
//
//  Created by renan veloso silva on 22/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <Foundation/Foundation.h>

//Entidades
#define EntityFood              @"FoodItemModel"
#define EntityCategory          @"FoodCategoryModel"
#define EntityType              @"FoodTypeModel"

//Titulos do NavigationBar
#define NavNameSettings         @"Ajustes"
#define NavNameSearch           @"Busca"
#define NavNameFavorites        @"Favoritos"
#define NavNameFoodCategory     @"Categorias"

//Nome das células
#define CellFoodItemName        @"FoodSubcategoriesCell"
#define CellCategoryName        @"FoodCategoryCell"

//Nome das Notifications
#define TabBarFavoriteSelected  @"TabBarFavoriteSelected"
#define TabBarSelected          @"TabBarSelected"
#define TabBarFoodSelected      @"TabBarFoodSelected"

//Titulo do BaseBar
#define BaseNameSettings         @"Ajustes"
#define BaseNameSearch          @"Busca"
#define BaseNameFavorites       @"Favoritos"
#define BaseNameFoodCategory    @"Alimentos"

//Formato do nome das imagens
#define ImageFood               @"Food"
#define ImageSettings           @"Settings"
#define ImageSearch             @"Search"
#define ImageFavorites          @"Favorites"

//Formato da chamada das imagens
#define FormatBaseBarImage      @"tabBarItem%@.png"

@interface PaleoDefines : NSObject

@end
