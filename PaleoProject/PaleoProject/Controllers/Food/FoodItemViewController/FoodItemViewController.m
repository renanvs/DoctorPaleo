//
//  FoodItemViewController.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FoodItemViewController.h"
#import <CoreGraphics/CoreGraphics.h>

@implementation FoodItemViewController

- (id)initWithItemModel:(FoodItemModel*)foodModel_
{
    self = [super init];
    if (self) {
        foodModel = foodModel_;
    }
    return self;
}

- (void)dealloc {
    [typeLabel release];
    [favoriteButton release];
    [foodImage release];
    [foodLabel release];
    [foodAbout release];
    [super dealloc];
}

- (IBAction)favoriteHandler:(id)sender {
    BOOL isFavorite = [foodModel.isFavorite boolValue];
    foodModel.isFavorite = [NSNumber numberWithBool:!isFavorite];
    [[[PaleoCoreData sharedInstance]context] save:nil];
    favoriteButton.userInteractionEnabled = NO;
    [self setFavoriteImage];

    [UIView animateWithDuration:.5 animations:^{
        favoriteButton.transform = CGAffineTransformRotate(CGAffineTransformMakeScale(1.6, 1.6), Degrees_To_Radians(180));
    }completion:^(BOOL finished){
        [UIView animateWithDuration:.5 animations:^{
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            favoriteButton.transform = CGAffineTransformMakeScale(1, 1);
            favoriteButton.userInteractionEnabled = YES;
        }];
    }];
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:foodModel.name];
    typeLabel.text = foodModel.type.name;
    foodImage.image = [UIImage imageNamed:foodModel.imageName];
    foodLabel.text = foodModel.name;
    foodAbout.text = foodModel.about;
    [self setFavoriteImage];
    [self setFoodTypeImage];
    [PaleoGA trackScreen:@"FoodItemScreen"];
}

-(void)viewDidLoad{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(setFavoriteImage) name:TabBarSelected object:nil];
}

-(void)setFavoriteImage{
    NSString *favoriteImageName = [foodModel.isFavorite boolValue] ? @"favorited" : @"favoritedNot";
    [favoriteButton setBackgroundImage:[UIImage imageNamed:favoriteImageName] forState:UIControlStateNormal];
}

-(void)setFoodTypeImage{
    NSString *type = foodModel.type.name;
    
    if ([type isEqualToString:@"Paleo"]) {
        typeImageView.image = [UIImage imageNamed:@"foodItemTopCellBorder1.png"];
    }else if ([type isEqualToString:@"Low-Carb"]) {
        typeImageView.image = [UIImage imageNamed:@"foodItemTopCellBorder2.png"];
    }else if ([type isEqualToString:@"Não LowCarb"]) {
        typeImageView.image = [UIImage imageNamed:@"foodItemTopCellBorder3.png"];
    }
}

@end
