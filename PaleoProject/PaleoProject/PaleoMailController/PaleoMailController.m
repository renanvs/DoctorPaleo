//
//  PaleoMailController.m
//  PaleoProject
//
//  Created by renan veloso silva on 22/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoMailController.h"

@implementation PaleoMailController

-(id)init{
    self =[super init];
    
    if (self) {
        self.mailComposeDelegate = self;
    }
    
    return self;
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
