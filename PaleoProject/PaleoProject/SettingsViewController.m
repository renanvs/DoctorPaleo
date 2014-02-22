//
//  SettingsViewController.m
//  PaleoProject
//
//  Created by renan veloso silva on 18/02/14.
//  Copyright (c) 2014 renan veloso silva. All rights reserved.
//

#import "SettingsViewController.h"
#import "PaleoMailController.h"

@implementation SettingsViewController

- (IBAction)share:(id)sender {
    //TODO: Implementar ShareKit
}

- (IBAction)about:(id)sender {
    //TODO: Implementar view de sobre a aplicação
}

- (IBAction)contact:(id)sender {
    //TODO: Mostrar controller de email (talvez custom para a aplicação)
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

- (IBAction)cleanData:(id)sender {
    //TODO: Implementar default para a aplicação, e testar o reset do banco
}

- (void)dealloc {

    [super dealloc];
}

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:NavNameSettings];
}

@end
