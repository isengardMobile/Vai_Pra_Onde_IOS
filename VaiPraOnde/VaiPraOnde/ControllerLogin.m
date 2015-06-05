//
//  ControllerLogin.m
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 12/02/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import "ControllerLogin.h"
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@implementation ControllerLogin

#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    DGTAuthenticateButton *authenticateButton = [DGTAuthenticateButton buttonWithAuthenticationCompletion:^(DGTSession *session, NSError *error) {
        // play with Digits session
    }];
    authenticateButton.center = self.view.center;
    [self.view addSubview:authenticateButton];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)btnLogar:(id)sender
{
    
}

#pragma LoginFacebook

- (IBAction)btnFacebook:(id)sender
{
    [PFFacebookUtils logInInBackgroundWithReadPermissions:@[ @"public_profile",@"email"] block:^(PFUser *user, NSError *error) {
        if (!user)
        {
           NSLog(@"O Usuário Cancelou o Login via Facebook");
        }
        else if (user.isNew)
        {
            NSLog(@"Usuário Cadastrado no Parse e conectado através do Facebook!");
            [self getInfosFacebook];
        }
        else
        {
            NSLog(@"Usuário conectado através do Facebook!");
        }
    }];
}

#pragma mark - Método para Buscar as Informação do Perfil do Usuário no Facebook

-(void)getInfosFacebook
{
   FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me?fields=first_name,last_name,gender,email" parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error)
    {
        if (!error)
        {
            NSArray *keysResult = @[@"id",@"first_name",@"last_name",@"gender",@"email"];
            NSArray *fields     = @[@"idFacebook",@"Nome",@"Sobrenome",@"Sexo",@"Email"];
            PFObject *infos = [PFObject objectWithClassName:@"InfosFacebook"];
            
            for (int i = 0; i <[keysResult count]; i++)
            {  
                if ([result valueForKey:[keysResult objectAtIndex:i]])
                {
                   infos[[fields objectAtIndex:i]] = [NSString stringWithFormat:@"%@",[result valueForKey:[keysResult objectAtIndex:i]]];
                   
                   if ([[keysResult objectAtIndex:i] isEqualToString:@"id"])
                   {
                    infos[@"urlFoto"] = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1",[result valueForKey:@"id"]];
                   }
                }
                
                
                [infos pinInBackgroundWithName:@"InfosFacebook" block:^(BOOL sucesso,NSError *erro){
                
                    if (sucesso)
                    {
                        [self performSegueWithIdentifier:@"segueCadastro" sender:nil];
                    }
                
                }];
            }
        }
        else
        {
            NSLog(@"Erro ao Busca Infos Facebook");
        }
    }];
}

@end
