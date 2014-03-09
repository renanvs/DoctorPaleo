//
//  PaleoGA.m
//  PaleoProject
//
//  Created by renan veloso silva on 04/03/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoGA.h"
#import "GAIFields.h"
#import "GAIDictionaryBuilder.h"

@implementation PaleoGA

static id<GAITracker> tracker;
static BOOL isDisabled;

static id _instance;
+ (PaleoGA *) sharedInstance{
    @synchronized(self){
        if (!_instance) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}

-(void)setTrackId:(NSString*)trackingId{
    if ([NSString isStringEmpty:trackingId]) {
        isDisabled = YES;
        return;
    }
    // Optional: automatically send uncaught exceptions to Google Analytics.
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    tracker = [[GAI sharedInstance] trackerWithTrackingId:trackingId];
}


//Tracking das Telas
+(void)trackScreen:(NSString*)screenName{
    if (isDisabled)return;
    
    [tracker set:kGAIScreenName value:screenName];
    [tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

@end
