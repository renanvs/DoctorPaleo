//
//  PaleoUtils.h
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PaleoNavigationController.h"

@interface PaleoUtils : NSObject{
    PaleoNavigationController *currentNavigationController;
}

@property (nonatomic, assign) PaleoNavigationController *currentNavigationController;

+ (PaleoUtils *) sharedInstance;

-(void)setCurrentNavigationController:(PaleoNavigationController *)_currentNavigationController;
-(void)pushViewControllerInCurrentNavigationController:(UIViewController*)viewController;

@end
