//
//  SettingsViewController.m
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "SettingsViewController.h"
#import "PaleoMailController.h"
#import "AboutAppView.h"

#import "SHKActionSheet.h"
#import "SHKItem.h"
#import "SHKiOSFacebook.h"
#import "SHKiOSTwitter.h"
#import "SHKLinkedIn.h"

@implementation SettingsViewController

- (IBAction)share:(id)sender {
    SHKItem *item = [SHKItem text:@"Test Share"];
    SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    [actionSheet showFromRect:[self findTopRootViewController].view.frame inView:[self findTopRootViewController].view animated:YES];
}

- (IBAction)about:(id)sender {
    SHKItem *item = [SHKItem text:@"Test Share"];
    [SHKLinkedIn shareItem:item];
    //TODO: Implementar view de sobre a aplicação
 //   AboutAppView *aboutAppview = [[[NSBundle mainBundle] loadNibNamed:@"AboutAppView" owner:self options:nil] lastObject];
   // [[self findTopRootViewController].view addSubview:aboutAppview];
}

- (IBAction)contact:(id)sender {
    SHKItem *item = [SHKItem text:@"Test Share"];
    [SHKiOSFacebook shareItem:item];

}

- (IBAction)cleanData:(id)sender {
    SHKItem *item = [SHKItem text:@"Test Share"];
    [SHKiOSTwitter shareItem:item];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        //Procurar como ajustar isso, testar e implementar atualizações
        [[PaleoCoreData sharedInstance] flushDatabase];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"ApplicationAlreadyRunned"];
        NSLog(@"Removendo dados do aplicativo");
    }
    
}

- (void)dealloc {

    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:NavNameSettings];
}

@end
