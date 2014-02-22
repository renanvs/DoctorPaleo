//
//  AppDelegate.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "AppDelegate.h"
#import "PaleoTabBarController.h"
#import "PaleoCoreData.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    //TODO: ver se é necessario
    //[PaleoCoreData sharedInstance];
    
    PaleoTabBarController *tabBarController = [[PaleoTabBarController alloc] init];
    
    self.window.rootViewController = tabBarController;
    
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
