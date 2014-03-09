//
//  FoodNavigationBar.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoNavigationController.h"

@implementation PaleoNavigationController

#pragma mark - initial method's

-(id)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    
    if (self) {
        //TODO: Criar classe Utils
        float iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (iOSVersion >= 7) {
            self.navigationBar.translucent = NO;
        }
    }
    return self;
}

#pragma mark - when view will/did appear

-(void)viewWillAppear:(BOOL)animated{
    [[PaleoUtils sharedInstance] setCurrentNavigationController:self];
}

@end
