//
//  Utils.m
//  PaleoProject
//
//  Created by renan veloso silva on 22/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "Utils.h"

@implementation Utils

static id _instance;
+ (Utils *) sharedInstance{
    @synchronized(self){
        if (!_instance) {
            _instance = [[self alloc] init];
        }
    }
    return _instance;
}

-(NSString*)getSafeLiteralString:(NSString*)text{
    NSDictionary *typeA= [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:@"ã", @"â", @"á", @"à", nil] forKey:@"a"];
    NSDictionary *typeE= [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:@"é", @"ê", @"è", nil] forKey:@"e"];
    NSDictionary *typeI= [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:@"í", @"î", @"ì", nil] forKey:@"i"];
    NSDictionary *typeO= [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:@"ó", @"ô", @"ò", @"õ", nil] forKey:@"o"];
    NSDictionary *typeU= [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:@"ú", @"û", @"ù", nil] forKey:@"u"];
    NSDictionary *typeC= [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:@"ç", nil] forKey:@"c"];
    NSArray *listType = [NSArray arrayWithObjects:typeA, typeE, typeI, typeO, typeU, typeC, nil];
    
    text = [text lowercaseString];
    for (NSDictionary *dic in listType) {
        NSString *key = [[dic allKeys] lastObject];
        NSArray *array = [dic objectForKey:key];
        for (NSString *charValue in array) {
            NSRange range = [text rangeOfString:charValue];
            if (range.length > 0) {
                text = [text stringByReplacingOccurrencesOfString:charValue withString:key];
            }
            
        }
    }
    
    return text;
    
}

+(CGRect) screenBoundsOnOrientation{
    CGRect screenBounds = [UIScreen mainScreen].bounds ;
    CGFloat width = CGRectGetWidth(screenBounds)  ;
    CGFloat height = CGRectGetHeight(screenBounds) ;
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    if(UIInterfaceOrientationIsPortrait(interfaceOrientation)){
        screenBounds.size = CGSizeMake(width, height);
    }else if(UIInterfaceOrientationIsLandscape(interfaceOrientation)){
        screenBounds.size = CGSizeMake(height, width);
    }
    return screenBounds ;
}

+(UIInterfaceOrientation)getDeviceOrientation{
    UIInterfaceOrientation interfaceOrientation = [UIApplication sharedApplication].statusBarOrientation;
    return interfaceOrientation;
}

@end

@implementation UIView (Additions)

-(void)setX:(float)newX{
    CGRect frame = self.frame;
    frame.origin.x = newX;
    self.frame = frame;
}

-(float)x{
    return self.frame.origin.x;
}

-(void) setY:(float) newY{
    CGRect frame = self.frame;
    frame.origin.x = newY;
    self.frame = frame;
}
-(float)y{
    return self.frame.origin.y;
}

-(void) setWidth:(float) newWidth{
    CGRect frame = self.frame;
    frame.size.width = newWidth;
    self.frame = frame;
}
-(float)width{
    return self.frame.size.width;
}

-(void) setHeight:(float) newHeight{
    CGRect frame = self.frame;
    frame.size.height = newHeight;
    self.frame = frame;
}
-(float)height{
    return self.frame.size.height;
}

@end

@implementation UIResponder (Aditions)
-(UIViewController *) findTopRootViewController {
	UIWindow *topWindow = [[UIApplication sharedApplication] keyWindow];
	
	if (topWindow.windowLevel != UIWindowLevelNormal) {
		NSArray *windows = [[UIApplication sharedApplication] windows];
		
		for(topWindow in windows) {
			if (topWindow.windowLevel == UIWindowLevelNormal) {
				break;
			}
		}
	}
	
    UIView *rootView = nil;
    
    if ([[topWindow subviews] count] != 0){
        rootView = [[topWindow subviews] objectAtIndex:0];
    }
    
	id nextResponder = [rootView nextResponder];
	
	return [nextResponder isKindOfClass:[UIViewController class]]
	? nextResponder
	: nil;
}
@end

@implementation NSString (JRAdditions)

+ (BOOL)isStringEmpty:(NSString *)string {
    if([string length] == 0) { //string is empty or nil
        return YES;
    }
    
    if(![[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] length]) {
        //string is all whitespace
        return YES;
    }
    
    return NO;
}

+ (BOOL)isStringWithNumeric:(NSString*)string{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
    NSNumber *number = [formatter numberFromString:string];
    bool status = number != nil;
    
    return status;
}

@end