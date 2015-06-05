//
//  ControllerMenu.m
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 20/02/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import "ControllerMenu.h"

@interface ControllerMenu ()

@end

@implementation ControllerMenu
@synthesize nomeUser,fotoUser;

static NSString * const reuseIdentifier = @"CellMenu";

- (void)viewDidLoad
{
    [super viewDidLoad];
     self.secoes = @[@"Home",@"Perfil",@"Seus Eventos",@"Convites",@"Explorar"];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[[self navigationController] navigationBar] setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)setInfosUser : (NSString *)nome : (NSData *)foto
{
    //Propriedades Nome do Usuário
    self.nomeUser               = [[UILabel alloc] initWithFrame:CGRectMake(5,100,310, 25)];
    self.nomeUser.textAlignment =  NSTextAlignmentCenter;
    self.nomeUser.font          = [UIFont fontWithName:@"OpenSans-Light" size:17];
    self.nomeUser.text          = nome;
    
    //Propriedades Foto do Usuário
    self.fotoUser                     = [[UIImageView alloc] initWithFrame:CGRectMake(115,5,85,85)];
    self.fotoUser.image               = [UIImage imageWithData:foto];
    self.fotoUser.layer.borderColor   = [UIColor blackColor].CGColor;
    self.fotoUser.layer.borderWidth   = 1.0;
    self.fotoUser.layer.cornerRadius  = CGRectGetWidth(self.fotoUser.bounds) / 2.0f;
    self.fotoUser.layer.masksToBounds = YES;
}

-(UIStoryboard *)defineStoryboard
{
    UIStoryboard *storyboard;
    int height = [UIScreen mainScreen].bounds.size.height;
    
    if (height == 480)
        storyboard = [UIStoryboard storyboardWithName:@"Iphone4"     bundle:nil];
    if (height == 568)
        storyboard = [UIStoryboard storyboardWithName:@"Iphone5"     bundle:nil];
    if (height == 667)
        storyboard = [UIStoryboard storyboardWithName:@"Iphone6"     bundle:nil];
    if (height == 736)
        storyboard = [UIStoryboard storyboardWithName:@"Iphone6Plus" bundle:nil];
    
    return storyboard;
}


#pragma TableViewData

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
     UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0,0,160,130)];
    [header  addSubview:self.nomeUser];
    [header  addSubview:self.fotoUser];
    
    return header;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0,0,160,70)];
    [footer setBackgroundColor:[UIColor blueColor]];
    
    return footer;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self secoes]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell   = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    
     UILabel     *nome       =  (UILabel *)      [cell viewWithTag:500];
    [nome setText:[[self secoes] objectAtIndex:indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    int     heightScreen = [UIScreen mainScreen].bounds.size.height;
    CGFloat heightRow = 0.0;
    
    if (heightScreen == 480)
        heightRow =  55;
    if (heightScreen == 568)
        heightRow =  65;
    
    return heightRow;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    int     heightScreen = [UIScreen mainScreen].bounds.size.height;
    CGFloat heightFooter = 0.0;
    
    if (heightScreen == 480)
        heightFooter=  75;
    if (heightScreen == 568)
        heightFooter =  70;
    
    return heightFooter;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self secoes]objectAtIndex:indexPath.row] isEqualToString:@"Home"])
        [self performSegueWithIdentifier:@"segueHome" sender:nil];
    
    if ([[[self secoes]objectAtIndex:indexPath.row] isEqualToString:@"Perfil"])
        [self performSegueWithIdentifier:@"seguePerfil" sender:nil];
    
    if ([[[self secoes]objectAtIndex:indexPath.row] isEqualToString:@"Seus Eventos"])
        [self performSegueWithIdentifier:@"segueEventos" sender:nil];
    
    if ([[[self secoes]objectAtIndex:indexPath.row] isEqualToString:@"Convites"])
        [self performSegueWithIdentifier:@"segueConvites" sender:nil];
    
    if ([[[self secoes]objectAtIndex:indexPath.row] isEqualToString:@"Explorar"])
        [self performSegueWithIdentifier:@"segueExplorar" sender:nil];
}

@end
