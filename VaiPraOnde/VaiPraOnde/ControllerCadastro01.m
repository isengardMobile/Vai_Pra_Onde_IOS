//
//  ControllerCadastro01.m
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 04/05/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import "ControllerCadastro01.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);

@implementation ControllerCadastro01

#pragma mark - View LifeCycle

- (void)viewDidLoad
{
   [super viewDidLoad];
   [self configTextField];
   [self configUIImageView];
    
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
    [[self txtNome]           setDelegate:self];
    [[self txtSobrenome]      setDelegate:self];
    [[self txtDtNascimento]   setDelegate:self];
    [[self txtCidadeNatal]    setDelegate:self];
    
    [[self txtNome]          addTarget:self action:@selector(nextTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [[self txtSobrenome]     addTarget:self action:@selector(nextTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
    [[self txtCidadeNatal]   addTarget:self action:@selector(nextTextField:) forControlEvents:UIControlEventEditingDidEndOnExit];
}

#pragma mark - Método para ativar á Edição do próximo TextField e Remover o Teclado da Tela

-(void)nextTextField:(UITextField *)textField
{
    if ([textField tag] <= 3)
        [ ((UITextField * )[[self view] viewWithTag:[textField tag]+ 1]) becomeFirstResponder];
    if ([textField tag] == 4)
        [textField resignFirstResponder];
}

#pragma mark - Método Invocado ao ser Detectado á ação de Touch na View Principal

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //Executa a remoção do Teclado da Tela, baseado no campo que está sendo editado.
    
    [[self txtNome]         resignFirstResponder];
    [[self txtSobrenome]    resignFirstResponder];
    [[self txtDtNascimento] resignFirstResponder];
    [[self txtCidadeNatal]  resignFirstResponder];
}

#pragma mark - Método Delegate do UITextField

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    // Define uma mask para o campo Data de Nascimento, e limita o número de caracteres.
    
   if ([textField tag] == 3 && [textField.text length] > 9 && ![string isEqualToString:@""])
        return NO;
    
   if ([textField tag] == 3 && ![string isEqualToString:@""] && ([textField.text length] == 2 || [textField.text length] == 5))
        textField.text = [textField.text stringByAppendingString:@"/"];
    
    return YES;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([textField tag] == 4)
        [self raiseView:YES];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    if ([textField tag] == 4)
        [self raiseView:NO];
    
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
        [UIView animateWithDuration:0.5 animations:^{[[self view] setFrame:CGRectMake(0,-95,width,height)];}];
    else
        [UIView animateWithDuration:0.5 animations:^{[[self view] setFrame:CGRectMake(0,0, width,height)];}];
}

#pragma mark - Método de Configuração do UIImageView

-(void)configUIImageView
{
    [[[self imageViewFoto] layer] setBorderColor:[UIColor blackColor].CGColor];
    [[[self imageViewFoto] layer] setBorderWidth:1.5];
    [[[self imageViewFoto] layer] setCornerRadius:CGRectGetWidth([[self imageViewFoto] bounds]) / 2.0];
    [[[self imageViewFoto] layer] setMasksToBounds:YES];
    [[self  imageViewFoto] setContentMode:UIViewContentModeScaleAspectFill];
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
            [[self txtNome]      setText:[NSString stringWithFormat:@"%@",[[objects lastObject] valueForKey:@"Nome"]]];
            [[self txtSobrenome] setText:[NSString stringWithFormat:@"%@",[[objects lastObject] valueForKey:@"Sobrenome"]]];
            
            if ([[[objects lastObject] objectForKey:@"Sexo"] isEqualToString:@"male"])
                [[self segmentSexo] setSelectedSegmentIndex:0];
            if ([[[objects lastObject] objectForKey:@"Sexo"] isEqualToString:@"female"])
                [[self segmentSexo] setSelectedSegmentIndex:1];
            if ([[objects lastObject] objectForKey:@"urlFoto"])
                [self downloadImage:[[objects lastObject] objectForKey:@"urlFoto"]];
        }
        
    }];
}

-(void)downloadImage : (NSString *)url
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0),^
    {
        
    NSData  *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
    UIImage *image     = [UIImage imageWithData:imageData];
    
    dispatch_async(dispatch_get_main_queue(), ^
    {
        [[self imageViewFoto] setImage:image];
    });
        
    });
}

@end
