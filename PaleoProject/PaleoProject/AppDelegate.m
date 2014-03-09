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
#import "SHKConfiguration.h"
#import "SharekitCustom.h"

#import "GAI.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self loadDefaultSocialConfiguration];
    NSString *ga =@"";
    //NSString *ga = @"UA-48609840-1";
    [[PaleoGA sharedInstance] setTrackId:ga];
    PaleoTabBarController *tabBarController = [[PaleoTabBarController alloc] init];
    
    self.window.rootViewController = tabBarController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

//Carrega as configurações padrões das redes sociais
- (void) loadDefaultSocialConfiguration{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SHK_FAVS_1"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SHK_FAVS_2"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SHK_FAVS_3"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SHK_FAVS_4"];
    SharekitCustom *customSharer = [[SharekitCustom alloc] init];
    [SHKConfiguration sharedInstanceWithConfigurator:customSharer];
}

@end
