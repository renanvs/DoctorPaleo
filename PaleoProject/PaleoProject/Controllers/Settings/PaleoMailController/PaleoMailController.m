//
//  PaleoMailController.m
//  PaleoProject
//
//  Created by renan veloso silva on 22/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoMailController.h"

@implementation PaleoMailController

#pragma mark - initial method's

-(id)init{
    self =[super init];
    
    if (self) {
        self.mailComposeDelegate = self;
    }
    
    return self;
}

#pragma mark - mailComposeView Delegate

//Remove o controller
-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
