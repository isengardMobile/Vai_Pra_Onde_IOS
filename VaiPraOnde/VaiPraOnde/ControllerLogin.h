//
//  ControllerLogin.h
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 12/02/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <DigitsKit/DigitsKit.h>

@interface ControllerLogin : UIViewController

//Propriedades View
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewOU;
@property (weak, nonatomic) IBOutlet UIButton    *btnLogar;
@property (weak, nonatomic) IBOutlet UIButton    *btnFacebook;
@property (weak, nonatomic) IBOutlet UIButton    *btnCadastro;

//Ações Botões
- (IBAction)btnLogar   :(id)sender;
- (IBAction)btnFacebook:(id)sender;

@end
