//
//  ControllerDetalheContato.m
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 11/02/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import "ControllerInformacoes.h"

@implementation ControllerInformacoes


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([_tipoApresentacao isEqualToString:@"DetalhesContato"])
        [[self lbCidade] setHidden:YES];
    
    [[[self imageViewFoto] layer] setBorderColor:[UIColor blackColor].CGColor];
    [[[self imageViewFoto] layer] setBorderWidth:2.0f];
    [[[self imageViewFoto] layer] setCornerRadius:CGRectGetWidth([[self imageViewFoto] bounds]) / 2.0f];
    [[[self imageViewFoto] layer] setMasksToBounds:YES];
    
    if (_foto == nil)
       [[self imageViewFoto]setImage:[UIImage imageNamed:@"contato.png"]];
    else
       [[self imageViewFoto] setImage:[UIImage imageWithData:_foto]];
    
    [[self txtNome] setText:_nome];
    [[self txtSobrenome] setText:_sobrenome];
    [[self txtEmail] setText:_email];
    [[self txtTelefone]setText:_telefone];
    [[self txtCidade] setText:_cidade];
    
    [self configTap];
    [self configView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)configView
{
    [[[super view] layer] setBorderWidth:2.0];
    [[[super view] layer] setBorderColor:[UIColor blackColor].CGColor];
}

-(void)configTap
{
      self.doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(acaoTap:)];
    [[self doubleTap] setNumberOfTapsRequired:2];
    [[self doubleTap] setDelaysTouchesBegan:YES];
    
    [[self view] addGestureRecognizer:[self doubleTap]];
}

-(void)acaoTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
      [self dismissViewControllerAnimated:YES completion:nil];
    }
}


@end
