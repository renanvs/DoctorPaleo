//
//  FoodItemViewController.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FoodItemViewController.h"

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
    NSString *favoriteTitle = [foodModel.isFavorite boolValue] ? @"Desfavoritar" : @"Favoritar";
    [favoriteButton setTitle:favoriteTitle forState:UIControlStateNormal];
    [[[PaleoCoreData sharedInstance]context] save:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:foodModel.name];
    typeLabel.text = foodModel.type.name;
    foodImage.image = [UIImage imageNamed:foodModel.imageName];
    foodLabel.text = foodModel.name;
    foodAbout.text = foodModel.about;
    NSString *favoriteTitle = [foodModel.isFavorite boolValue] ? @"Desfavoritar" : @"Favoritar";
    [favoriteButton setTitle:favoriteTitle forState:UIControlStateNormal];
}

@end
