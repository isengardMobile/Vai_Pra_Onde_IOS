//
//  ControllerContatos.m
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 28/01/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import "ControllerContatos.h"

@interface ControllerContatos ()

@end

@implementation ControllerContatos

static NSString * const reuseIdentifier = @"CellContato";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     self.contatosDevice = [GetContatosDevice compartilharContatos];
     self.contatos       = [self.contatosDevice getContatos];
    [self configTap];
    
    [[self collectionView] setAllowsMultipleSelection:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)configTap
{
      self.doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(acaoTap:)];
    [[self doubleTap] setNumberOfTapsRequired:2];
    [[self doubleTap] setDelaysTouchesBegan:YES];
   
    [[self collectionView] addGestureRecognizer:[self doubleTap]];
}

-(void)acaoTap:(UITapGestureRecognizer *)sender
{
    if (sender.state == UIGestureRecognizerStateEnded)
    {
        CGPoint      point        = [sender locationInView: [self collectionView]];
        NSIndexPath *index        = [[self collectionView] indexPathForItemAtPoint:point];
        
        if (index)
        {
             Contato *contato = (Contato *)[self.contatos objectAtIndex:index.row];
            [self performSegueWithIdentifier:@"segueDetalheContato" sender:contato];
        }
    }
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.contatos count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier
                                                 forIndexPath:indexPath];
    
    UILabel     *nome       =  (UILabel *)      [cell viewWithTag:50];
    
    UIImageView *foto        = (UIImageView *)  [cell viewWithTag:100];
    foto.layer.borderColor   = [UIColor whiteColor].CGColor;
    foto.layer.borderWidth   = 2.0;
    foto.layer.cornerRadius  = CGRectGetWidth(foto.bounds) / 2.0f;
    foto.layer.masksToBounds = YES;
    
    Contato *contato = (Contato *)[self.contatos objectAtIndex:indexPath.row];
    
    if ([contato getFoto] == nil)
        [foto setImage:[UIImage imageNamed:@"contato.png"]];
    else
        [foto setImage:[UIImage imageWithData:[contato getFoto]]];
    
    NSString *nomeComposto = [NSString stringWithFormat:@"%@ %@",[contato getNome],[contato getSobrenome]];
    
    if ([contato getSobrenome]  && [nomeComposto length] < 15)
        [nome setText: nomeComposto];
    else
        [nome setText:contato.nome];
    
    return cell;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *header = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
    
      header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                               withReuseIdentifier:@"Header" forIndexPath:indexPath ];
      header.backgroundColor = [UIColor colorWithRed:0.718 green:0.82 blue:0.067 alpha:1];
    }
    
    UILabel *titulo = (UILabel *) [header viewWithTag:50];
    [titulo setText:@"Contatos"];
    
    return header;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *foto          = (UIImageView *)  [cell viewWithTag:100];
    [[foto layer] setBorderColor:[UIColor colorWithRed:0.718 green:0.82 blue:0.067 alpha:1.0].CGColor];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    UIImageView *foto          = (UIImageView *)  [cell viewWithTag:100];
    [[foto layer] setBorderColor:[UIColor whiteColor].CGColor];
}


-(void)reloadContatos
{
    [self.collectionView reloadData];
}

#pragma PerformSegue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(Contato *)obj
{
    if([segue.identifier isEqualToString:@"segueDetalheContato"])
    {
        ControllerInformacoes *view = [segue destinationViewController];
        
        view.transitioningDelegate = self;
        view.modalPresentationStyle = UIModalPresentationCustom;
       
        view->_tipoApresentacao = @"DetalhesContato";
        view->_foto       = [obj getFoto];
        view->_nome       = [obj getNome];
        view->_sobrenome  = [obj getSobrenome];
        view->_email      = [obj getEmail];
        view->_telefone   = [obj getTelefone];
    }
}

#pragma mark - UIViewControllerTransitionDelegate -

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [[ApresentacaoModal alloc] init];
}

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [[DismissModal alloc] init];
}

- (IBAction)btnVoltar:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
