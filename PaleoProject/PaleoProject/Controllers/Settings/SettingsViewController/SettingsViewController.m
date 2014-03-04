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

@implementation SettingsViewController

- (IBAction)share:(id)sender {
    SHKItem *item = [SHKItem text:@"Test Share"];
    SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    [actionSheet showFromRect:[self findTopRootViewController].view.frame inView:[self findTopRootViewController].view animated:YES];
}

- (IBAction)about:(id)sender {
    //TODO: Implementar view de sobre a aplicação
    AboutAppView *aboutAppview = [[[NSBundle mainBundle] loadNibNamed:@"AboutAppView" owner:self options:nil] lastObject];
    [[self findTopRootViewController].view addSubview:aboutAppview];
}

- (IBAction)contact:(id)sender {
    if (![PaleoMailController canSendMail]) {
        [[UIAlertView alloc] initWithTitle:@"Atenção" message:@"Verifique existe alguma conta de email cadastrada no dispositivo" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    }else{
        PaleoMailController *mailController = [[PaleoMailController alloc] init];
        [mailController setMessageBody:@"Teste de mensagem" isHTML:NO];
        [mailController setToRecipients:[NSArray arrayWithObject:@"renanvelososilva@gmail.com"]];
        [mailController setSubject:@"Teste de assunto"];
        [[[mailController navigationBar] topItem]setTitle:@"custom title"];
        [self presentViewController:mailController animated:YES completion:nil];
    }

}

- (void)dealloc {

    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:NavNameSettings];
    [PaleoGA trackScreen:@"SettingsScreen"];
}

@end
