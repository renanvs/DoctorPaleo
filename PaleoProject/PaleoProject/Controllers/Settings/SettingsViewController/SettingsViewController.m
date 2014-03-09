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

#pragma mark - IBAction's

//Compartilhamento de redes sociais
- (IBAction)share:(id)sender {
    //todo: ajustar o que será compartilhado
    SHKItem *item = [SHKItem text:@"Test Share"];
    SHKActionSheet *actionSheet = [SHKActionSheet actionSheetForItem:item];
    [actionSheet showFromRect:[self findTopRootViewController].view.frame inView:[self findTopRootViewController].view animated:YES];
}

//Apresenta as informações do aplicativo (que é uma webView)
- (IBAction)about:(id)sender {
    //TODO: Implementar view de sobre a aplicação
    AboutAppView *aboutAppview = [[[NSBundle mainBundle] loadNibNamed:@"AboutAppView" owner:self options:nil] lastObject];
    [[self findTopRootViewController].view addSubview:aboutAppview];
}

//Apresenta o controller de email, isso se o dispositivo estiver habilitado para isso
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

#pragma mark - when view will/did appear

-(void)viewWillAppear:(BOOL)animated{
    [self.navigationItem setTitle:NavNameSettings];
    [PaleoGA trackScreen:SettingsScreen];
}

#pragma mark finishing method's

- (void)dealloc {
    
    [super dealloc];
}
@end
