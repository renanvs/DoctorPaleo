//
//  AboutAppView.m
//  PaleoProject
//
//  Created by renan veloso silva on 22/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "AboutAppView.h"

@implementation AboutAppView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
    [aboutWebView release];
    [super dealloc];
}
- (IBAction)closeButtonHandler:(id)sender {
    [self removeFromSuperview];
}

-(void)willMoveToSuperview:(UIView *)newSuperview{
    NSURL *path = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"about" ofType:@"html"]];
    NSString *html = [NSString stringWithContentsOfURL:path encoding:NSUTF8StringEncoding error:nil];
    
    [aboutWebView loadHTMLString:html baseURL:nil];
}

@end
