//
//  ControllerPageView.m
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 04/05/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import "ControllerPageView.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@implementation ControllerPageView

#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initControllers];
    [self initPageViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Método que obtêm á instância do Controller via Storyboard
-(void)initControllers
{
    [self setController01:[[self storyboard] instantiateViewControllerWithIdentifier:@"Cadastro01"]];
    [self setController02:[[self storyboard] instantiateViewControllerWithIdentifier:@"Cadastro02"]];
}

#pragma mark - Método de Inicialização e Configuração do PageViewController

-(void)initPageViewController
{
  [self setPageViewController:[[self storyboard] instantiateViewControllerWithIdentifier:@"PageViewController"]];
  [self.pageViewController  setViewControllers :@[[self controller01]] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
  [self.pageViewController.view setFrame :CGRectMake(0,50,320,400)];
  [self.pageViewController  didMoveToParentViewController:self];
    
  [self addChildViewController:[self pageViewController]];
  [self.view addSubview       :[self.pageViewController view]];
}

#pragma mark - Métodos de Ações dos Botões
- (IBAction)btnProsseguir:(id)sender
{
    if ([[[[self pageViewController] viewControllers] lastObject] isKindOfClass:[ControllerCadastro01 class]])
    {
        [[self pageViewController] setViewControllers:@[[self controller02]] direction:UIPageViewControllerNavigationDirectionForward  animated:YES completion:nil];
        [[self btnVoltar]          setHidden:NO];
        [[self btnProsseguir]      setHidden:YES];
        [[self btnFinalizar]       setHidden:NO];
    }
}

- (IBAction)btnVoltar:(id)sender
{
    if ([[[[self pageViewController] viewControllers] lastObject] isKindOfClass:[ControllerCadastro02 class]])
    {
        [[self pageViewController] setViewControllers:@[[self controller01]] direction:UIPageViewControllerNavigationDirectionReverse  animated:YES completion:nil];
        [[self btnProsseguir]      setHidden:NO];
        [[self btnVoltar]          setHidden:YES];
        [[self btnFinalizar]       setHidden:YES];
    }
}

- (IBAction)btnFinalizar:(id)sender
{

}

@end
