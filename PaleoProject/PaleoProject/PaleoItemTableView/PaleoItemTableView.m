//
//  PaleoItemTableView.m
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "PaleoItemTableView.h"
#import "FoodItemViewController.h"

@implementation PaleoItemTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.delegate = self;
    }
    return self;
}

-(id)init{
    self = [super init];
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


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FoodItemViewController *foodItemController = [[FoodItemViewController alloc] init];
    [[PaleoUtils sharedInstance] pushViewControllerInCurrentNavigationController:foodItemController];

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
    
    if (section == 0) {
        [view setBackgroundColor:[UIColor redColor]];
    }
    
    if (section == 1) {
        [view setBackgroundColor:[UIColor greenColor]];
    }
    
    return view;
}


@end
