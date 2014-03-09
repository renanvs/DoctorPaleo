//
//  PaleoUtils.m
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoUtils.h"
#import "PaleoSqlite.h"
@implementation PaleoUtils
@synthesize currentNavigationController;

#pragma mark - Initial method's

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
        PaleoSqlite *sqlite = [[PaleoSqlite alloc] init];
        [sqlite validateInfo];
    }
    
    return self;
}

#pragma mark - Auxiliar Method's

//Armazena a referência do navigationController atual
-(void)setCurrentNavigationController:(PaleoNavigationController *)_currentNavigationController{
    currentNavigationController = _currentNavigationController;
}

//Chama o viewController solicitado no currentNavigationController
-(void)pushViewControllerInCurrentNavigationController:(UIViewController*)viewController{
    [currentNavigationController pushViewController:viewController animated:YES];
}

@end
