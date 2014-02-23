//
//  SharekitCustom.m
//  PaleoProject
//
//  Created by renan veloso silva on 23/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "SharekitCustom.h"

@implementation SharekitCustom

- (NSString*)facebookAppId {
	return @"248660908614436";
}

-(NSNumber *)forcePreIOS6FacebookPosting{
    return NO;
}

- (NSNumber*)forcePreIOS5TwitterAccess {
    return [NSNumber numberWithBool:NO];
}

- (NSString*)twitterConsumerKey {
	return @"q7bNiTEWsYwcocqHNVVQ";
}

- (NSString*)twitterSecret {
	return @"mSyikId8RUAfjjUOib0RnjAkteYK5SGbfMGBGUQI8";
}
// You need to set this if using OAuth, see note above (xAuth users can skip it)
- (NSString*)twitterCallbackUrl {
	return @"";
}

// LinkedIn - https://www.linkedin.com/secure/developer
- (NSString*)linkedInConsumerKey {
	return @"jsnrk7iludvi";
}

- (NSString*)linkedInSecret {
	return @"hQHIoBVc1GaTmXt6";
}

- (NSString*)linkedInCallbackUrl {
	return @"";
}


// ShareMenu Ordering
- (NSNumber*)shareMenuAlphabeticalOrder {
	return [NSNumber numberWithInt:0];// Setting this to 1 will show list in Alphabetical Order, setting to 0 will follow the order in SHKShares.plist
}

// SHKActionSheet settings
- (NSNumber*)showActionSheetMoreButton {
	return [NSNumber numberWithBool:NO];// Setting this to true will show More... button in SHKActionSheet, setting to false will leave the button out.
}

/*
 Favorite Sharers
 ----------------
 These values are used to define the default favorite sharers appearing on ShareKit's action sheet.
 */
- (NSArray*)defaultFavoriteURLSharers {
    NSArray *favSharers = [self defaultShareres];
    return favSharers;
}
- (NSArray*)defaultFavoriteImageSharers {
    NSArray *favSharers = [self defaultShareres];
    return favSharers;
}
- (NSArray*)defaultFavoriteTextSharers {
    NSArray *favSharers = [self defaultShareres];
    return favSharers;
}

//by default, user can see last used sharer on top of the SHKActionSheet. You can switch this off here, so that user is always presented the same sharers for each SHKShareType.
- (NSNumber*)autoOrderFavoriteSharers {
    return [NSNumber numberWithBool:NO];
}

- (NSNumber*)maxFavCount {
	return [NSNumber numberWithInt:5];
}

- (NSNumber*)allowOffline {
	return [NSNumber numberWithBool:true];
}

- (NSNumber*)allowAutoShare {
	return [NSNumber numberWithBool:true];
}

/*
 Debugging settings
 ------------------
 see Debug.h
 */



/* SHKMail */

//You can use this to prefill recipients. User enters them in MFMailComposeViewController by default. Should be array of NSStrings.
- (NSArray *)mailToRecipients {
	return nil;
}

- (NSNumber*)isMailHTML {
    return [NSNumber numberWithInt:1];
}

//used only if you share image. Values from 1.0 to 0.0 (maximum compression).
- (NSNumber*)mailJPGQuality {
    return [NSNumber numberWithFloat:1];
}

// append 'Sent from <appName>' signature to Email
- (NSNumber*)sharedWithSignature {
	return [NSNumber numberWithInt:0];
}

-(NSArray*)defaultShareres{
    NSMutableArray *sharersList = [[[NSMutableArray alloc] init] autorelease];
    [sharersList addObject:@"SHKLinkedIn"];
    [sharersList addObject:@"SHKiOSFacebook"];
    [sharersList addObject:@"SHKiOSTwitter"];
    [sharersList addObject:@"SHKMail"];
    return sharersList;
}

@end
