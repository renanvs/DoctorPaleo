//
//  AboutAppView.h
//  PaleoProject
//
//  Created by renan veloso silva on 22/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIWebView.h>

@interface AboutAppView : UIView{
    
    IBOutlet UIWebView *aboutWebView;
}

- (IBAction)closeButtonHandler:(id)sender;

@end
