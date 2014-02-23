//
//  Utils.h
//  PaleoProject
//
//  Created by renan veloso silva on 22/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utils : NSObject

+ (Utils *) sharedInstance;

-(NSString*)getSafeLiteralString:(NSString*)text;

+(CGRect) screenBoundsOnOrientation;

+(UIInterfaceOrientation)getDeviceOrientation;

@end

@interface NSString (custom)

+ (BOOL)isStringEmpty:(NSString *)string;
+ (BOOL)isStringWithNumeric:(NSString*)string;

@end

@interface UIView (Additions)

-(void) setX:(float) newX;
-(float)x;

-(void) setY:(float) newY;
-(float)y;

-(void) setWidth:(float) newWidth;
-(float)width;

-(void) setHeight:(float) newHeight;
-(float)height;


@end

@interface UIResponder (Aditions)
-(UIViewController *) findTopRootViewController;
@end