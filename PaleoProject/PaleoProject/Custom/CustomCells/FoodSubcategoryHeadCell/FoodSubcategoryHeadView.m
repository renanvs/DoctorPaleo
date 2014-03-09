//
//  FoodSubcategoryHeadCell.m
//  PaleoProject
//
//  Created by renan veloso silva on 22/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FoodSubcategoryHeadView.h"

@implementation FoodSubcategoryHeadView
@synthesize headBackgroundImageView;

#pragma mark - set info to UI

//Adiciona o texto para o UI
-(void)setTypeName:(NSString*)typeName{
    typeLabel.text = typeName;
}
#pragma mark - finishing method's

- (void)dealloc {
    [headBackgroundImageView release];
    [super dealloc];
}
@end
