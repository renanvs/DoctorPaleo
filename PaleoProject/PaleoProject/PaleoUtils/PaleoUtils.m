//
//  PaleoUtils.m
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoUtils.h"
#import "PaleoCoreData.h"

@implementation PaleoUtils
@synthesize currentNavigationController;

static id _instance;
+ (PaleoUtils *) sharedInstance{
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
        [PaleoCoreData sharedInstance];
    }
    
    return self;
}

-(void)setCurrentNavigationController:(PaleoNavigationController *)_currentNavigationController{
    currentNavigationController = _currentNavigationController;
}

-(void)pushViewControllerInCurrentNavigationController:(UIViewController*)viewController{
    [currentNavigationController pushViewController:viewController animated:YES];
}

@end
