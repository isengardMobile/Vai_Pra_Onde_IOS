//
//  ControllerContatos.h
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 28/01/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <pop/POP.h>
#import "GetContatosDevice.h"
#import "Contato.h"
#import "ControllerInformacoes.h"
#import "ApresentacaoModal.h"
#import "DismissModal.h"

@interface ControllerContatos : UICollectionViewController<UIViewControllerTransitioningDelegate>

//Propriedades
@property (nonatomic) GetContatosDevice      *contatosDevice;
@property (nonatomic) NSMutableArray         *contatos;
@property (nonatomic) UITapGestureRecognizer *doubleTap;

//Ações Btn
- (IBAction)btnVoltar:(id)sender;

@end
