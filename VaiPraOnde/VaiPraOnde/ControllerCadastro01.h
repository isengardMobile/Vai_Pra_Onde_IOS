//
//  ControllerCadastro01.h
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 04/05/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@protocol ValidationOfFields

-(void)informationsOfTheFields:(NSDictionary *)informations withFilled:(BOOL)filled;

@end

@interface ControllerCadastro01 : UIViewController<UITextFieldDelegate>

//Propriedades View
@property (weak, nonatomic) IBOutlet UIImageView        *imageViewFoto;

@property (weak, nonatomic) IBOutlet UITextField        *txtNome;
@property (weak, nonatomic) IBOutlet UITextField        *txtSobrenome;
@property (weak, nonatomic) IBOutlet UITextField        *txtDtNascimento;
@property (weak, nonatomic) IBOutlet UITextField        *txtCidadeNatal;

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentSexo;

//Propriedades
@property (nonatomic, assign) id<ValidationOfFields>delegate;

@end
