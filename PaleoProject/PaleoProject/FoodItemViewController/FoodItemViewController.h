//
//  FoodItemViewController.h
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EntityItemModel.h"
#import "EntityItemType.h"

@interface FoodItemViewController : UIViewController{
    IBOutlet UILabel *typeLabel;
    IBOutlet UIButton *favoriteButton;
    IBOutlet UIImageView *itemImage;
    IBOutlet UILabel *itemLabel;
    IBOutlet UITextView *itemAbout;
    EntityItemModel *itemModel;
}

-(IBAction)favoriteHandler:(id)sender;
- (id)initWithItemModel:(EntityItemModel*)item;

@end
