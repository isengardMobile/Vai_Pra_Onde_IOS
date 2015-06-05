//
//  ControllerPageView.h
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 04/05/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControllerCadastro01.h"
#import "ControllerCadastro02.h"

@interface ControllerPageView : UIViewController


//Propriedades View
@property (nonatomic,strong)         UIPageViewController *pageViewController;
@property (weak, nonatomic) IBOutlet UIButton             *btnProsseguir;
@property (weak, nonatomic) IBOutlet UIButton             *btnVoltar;
@property (weak, nonatomic) IBOutlet UIButton             *btnFinalizar;

//Propriedades
@property (nonatomic,strong) ControllerCadastro01 *controller01;
@property (nonatomic,strong) ControllerCadastro02 *controller02;

// Método de Ação do Botão
- (IBAction)btnProsseguir:(id)sender;
- (IBAction)btnVoltar    :(id)sender;
- (IBAction)btnFinalizar :(id)sender;


@end
