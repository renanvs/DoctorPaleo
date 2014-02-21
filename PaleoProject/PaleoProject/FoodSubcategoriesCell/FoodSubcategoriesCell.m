//
//  FoodSubcategoriesCell.m
//  PaleoProject
//
//  Created by renan veloso silva on 16/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "FoodSubcategoriesCell.h"

@implementation FoodSubcategoriesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setItemModel:(EntityItemModel*)itemModel{
    item = itemModel;
    itemLabel.text = itemModel.name;
    itemImage.image = [UIImage imageNamed:itemModel.imageName];
}

- (void)dealloc {
    [itemImage release];
    [itemLabel release];
    [super dealloc];
}
@end
