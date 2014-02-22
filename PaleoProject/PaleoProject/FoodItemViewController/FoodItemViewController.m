//
//  FoodItemViewController.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FoodItemViewController.h"

@interface FoodItemViewController ()

@end

@implementation FoodItemViewController

- (id)initWithItemModel:(EntityItemModel*)item
{
    self = [super init];
    if (self) {
        itemModel = item;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [typeLabel release];
    [favoriteButton release];
    [itemImage release];
    [itemLabel release];
    [itemAbout release];
    [super dealloc];
}

- (IBAction)favoriteHandler:(id)sender {
    BOOL isFavorite = [itemModel.isFavorite boolValue];
    itemModel.isFavorite = [NSNumber numberWithBool:!isFavorite];
    NSString *favoriteTitle = [itemModel.isFavorite boolValue] ? @"Desfavoritar" : @"Favoritar";
    [favoriteButton setTitle:favoriteTitle forState:UIControlStateNormal];
    //r[[[PaleoCoreData sharedInstance]context] save:nil];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:itemModel.name];
    typeLabel.text = itemModel.type.name;
    itemImage.image = [UIImage imageNamed:itemModel.imageName];
    itemLabel.text = itemModel.name;
    itemAbout.text = itemModel.about;
    NSString *favoriteTitle = [itemModel.isFavorite boolValue] ? @"Desfavoritar" : @"Favoritar";
    [favoriteButton setTitle:favoriteTitle forState:UIControlStateNormal];
}

@end
