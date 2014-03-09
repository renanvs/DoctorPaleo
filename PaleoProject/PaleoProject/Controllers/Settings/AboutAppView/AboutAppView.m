//
//  AboutAppView.m
//  PaleoProject
//
//  Created by renan veloso silva on 22/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "AboutAppView.h"

@implementation AboutAppView

#pragma mark - IBAction's

//remove essa view
- (IBAction)closeButtonHandler:(id)sender {
    [self removeFromSuperview];
}

#pragma mark - HTML Loading

//Carrega o HTML com as informações do App
-(void)willMoveToSuperview:(UIView *)newSuperview{
    NSURL *path = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"]];
    NSString *html = [NSString stringWithContentsOfURL:path encoding:NSUTF8StringEncoding error:nil];
    
    [aboutWebView loadHTMLString:html baseURL:nil];
}

#pragma mark - finishing method's

- (void)dealloc {
    [aboutWebView release];
    [super dealloc];
}

@end
