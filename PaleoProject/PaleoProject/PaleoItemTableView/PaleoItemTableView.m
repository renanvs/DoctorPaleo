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
@synthesize delegateList;
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
    NSArray *itemList = nil;
    
    if ([delegateList respondsToSelector:@selector(itemList)]) {
        itemList = [delegateList itemList];
    }
    
    if (!itemList) {
        return;
    }
    
    NSArray *typeList = [[PaleoFoodManager sharedInstance] getTypeItemListWithItemList:itemList];
    EntityItemType *typeModel = [typeList objectAtIndex:indexPath.section];
    NSDictionary *dic = [[PaleoFoodManager sharedInstance] getDictionaryWithTypeList:typeList AndItemList:itemList];
    NSArray *itemListInType = [dic objectForKey:typeModel.name];
    EntityItemModel *itemModel = [itemListInType objectAtIndex:indexPath.row];
    FoodItemViewController *foodItemViewController = [[FoodItemViewController alloc] initWithItemModel:itemModel];
    
    [[PaleoUtils sharedInstance] pushViewControllerInCurrentNavigationController:foodItemViewController];

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