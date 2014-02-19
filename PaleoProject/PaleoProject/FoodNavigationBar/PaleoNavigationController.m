//
//  FoodNavigationBar.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoNavigationController.h"

@implementation PaleoNavigationController

- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithRootViewController:(UIViewController *)rootViewController{
    self = [super initWithRootViewController:rootViewController];
    
    if (self) {
        
        float iOSVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
        if (iOSVersion >= 7) {
            self.navigationBar.translucent = NO;
        }
    }
    return self;
}


-(void)viewWillAppear:(BOOL)animated{
    [[PaleoUtils sharedInstance] setCurrentNavigationController:self];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
