//
//  PeleoTabBarController.h
//  PaleoProject
//
//  Created by renan veloso silva on 17/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaleoNavigationController.h"

@interface PaleoTabBarController : UITabBarController <UITabBarDelegate, UITabBarControllerDelegate>{
    PaleoNavigationController *favoritesPaleoNavigationController;
    PaleoNavigationController *categoriesPaleoNavigationController;
    PaleoNavigationController *searchPaleoNavigationController;
    PaleoNavigationController *settingsPaleoNavigationController;
    
}

@end
