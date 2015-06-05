//
//  ControllerCadastro02.m
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 04/05/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import "ControllerCadastro02.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@implementation ControllerCadastro02

#pragma mark - View LifeCycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configTextField];
    
    if ([PFUser currentUser])
    {
        [self initFields];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Método de Configuração dos TextFields

-(void)configTextField
{
    [[self txtCelular]    setDelegate:self];
    [[self txtEmail]      setDelegate:self];
    [[self txtUsername]   setDelegate:self];
    [[self txtSenha]      setDelegate:self];
    
    [[self txtEmail]      addTarget:self action:@selector(nextTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [[self txtUsername]   addTarget:self action:@selector(nextTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [[self txtSenha]      addTarget:self action:@selector(nextTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

#pragma mark - Método para ativar á Edição do próximo TextField e Remover o Teclado da Tela

-(void)nextTextField:(UITextField *)textField
{
    if ([textField tag] <= 3)
        [ ((UITextField * )[[self view] viewWithTag:[textField tag]+ 1]) becomeFirstResponder];
    if ([textField tag] == 4)
    {
        [textField resignFirstResponder];
        [self raiseView:NO];
    }
    
}

#pragma mark - Método Invocado ao ser Detectado á ação de Touch na View Principal

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Executa a remoção do Teclado da Tela, baseado no campo que está sendo editado.
    
    [[self txtCelular]  resignFirstResponder];
    [[self txtEmail]    resignFirstResponder];
    [[self txtUsername] resignFirstResponder];
    [[self txtSenha]    resignFirstResponder];
    
    [self raiseView:NO];
}

#pragma mark - Método Delegate do UITextField

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // Define uma mask para o campo Data de Nascimento, e limita o número de caracteres.
    
    if ([textField tag] == 1 && [textField.text length] > 13 && ![string isEqualToString:@""])
        return NO;
    
    if ([textField tag] == 1 && ![string isEqualToString:@""] && [textField.text length] == 0)
        textField.text  = [textField.text stringByAppendingString:@"("];
        
    if ([textField tag] == 1 && ![string isEqualToString:@""] && [textField.text length] == 3)
        textField.text  = [textField.text stringByAppendingString:@")"];
    
    if ([textField tag] == 1 && ![string isEqualToString:@""] && [textField.text length] == 9)
        textField.text  = [textField.text stringByAppendingString:@"-"];
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField tag] == 4 || [textField tag] == 3)
        [self raiseView:YES];
    
    return YES;
}

#pragma mark - Métodos de Elevação do View Principal com Animação

//Animação para Elevar a Vista, para melhor visualização dos campos de textos.
-(void)raiseView : (BOOL)up
{
    //Obtêm a Largura da Tela Baseado no Device
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    //Obtêm a Altura da Tela Baseado no Device
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    if (up)
        [UIView animateWithDuration:0.5 animations:^{[[self view] setFrame:CGRectMake(0,-15,width,height)];}];
    else
        [UIView animateWithDuration:0.5 animations:^{[[self view] setFrame:CGRectMake(0,0, width,height)];}];
}


#pragma mark - Método para Inicialização dos Fields com as informações obtidas via Logia Social
-(void)initFields
{
    PFQuery *query = [PFQuery queryWithClassName:@"InfosFacebook"];
    [query fromLocalDatastore];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error)
     {
         if (!error)
         {
            [[self txtEmail] setText:[NSString stringWithFormat:@"%@",[[objects lastObject] valueForKey:@"Email"]]];
         }
         
     }];
    
    
}



@end
