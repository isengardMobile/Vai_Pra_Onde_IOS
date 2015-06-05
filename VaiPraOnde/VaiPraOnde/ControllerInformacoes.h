//
//  ControllerDetalheContato.h
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 11/02/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ControllerInformacoes : UIViewController
{
    @public
    NSData   *_foto;
    NSString *_nome;
    NSString *_sobrenome;
    NSString *_email;
    NSString *_telefone;
    NSString *_cidade;
    NSString *_tipoApresentacao;
}

//Propriedades View
@property (weak, nonatomic) IBOutlet UIImageView *imageViewFoto;

@property (weak, nonatomic) IBOutlet UILabel     *lbNome;
@property (weak, nonatomic) IBOutlet UILabel     *txtNome;

@property (weak, nonatomic) IBOutlet UILabel     *lbSobrenome;
@property (weak, nonatomic) IBOutlet UILabel     *txtSobrenome;

@property (weak, nonatomic) IBOutlet UILabel     *lbEmail;
@property (weak, nonatomic) IBOutlet UILabel     *txtEmail;

@property (weak, nonatomic) IBOutlet UILabel     *lbTelefone;
@property (weak, nonatomic) IBOutlet UILabel     *txtTelefone;

@property (weak, nonatomic) IBOutlet UILabel     *lbCidade;
@property (weak, nonatomic) IBOutlet UILabel     *txtCidade;

//Propriedades
@property (nonatomic) UITapGestureRecognizer *doubleTap;

@end
