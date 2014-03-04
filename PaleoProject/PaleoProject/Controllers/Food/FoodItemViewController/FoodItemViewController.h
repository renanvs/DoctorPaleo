//
//  FoodItemViewController.h
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FoodItemModel.h"
#import "FoodTypeModel.h"

@interface FoodItemViewController : UIViewController{
    IBOutlet UILabel *typeLabel;
    IBOutlet UIButton *favoriteButton;
    IBOutlet UIImageView *foodImage;
    IBOutlet UILabel *foodLabel;
    IBOutlet UITextView *foodAbout;
    IBOutlet UIImageView *typeImageView;
    FoodItemModel *foodModel;
}

-(IBAction)favoriteHandler:(id)sender;
-(id)initWithItemModel:(FoodItemModel*)foodModel_;

@end
