//
//  FoodSubcategoryHeadCell.h
//  PaleoProject
//
//  Created by renan veloso silva on 22/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodSubcategoryHeadView : UIView{
    IBOutlet UILabel *typeLabel;
    UIImageView *headBackgroundImageView;
}

@property (retain, nonatomic) IBOutlet UIImageView *headBackgroundImageView;

-(void)setTypeName:(NSString*)typeName;

@end
