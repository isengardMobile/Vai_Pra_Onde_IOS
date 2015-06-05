//
//  ControllerCadastro02.h
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 04/05/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface ControllerCadastro02 : UIViewController <UITextFieldDelegate>

//Propriedades View
@property (weak, nonatomic) IBOutlet UITextField *txtCelular;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtUsername;
@property (weak, nonatomic) IBOutlet UITextField *txtSenha;


@end
