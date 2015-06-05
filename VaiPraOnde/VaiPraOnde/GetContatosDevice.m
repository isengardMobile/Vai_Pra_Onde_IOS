//
//  ContatosDevice.m
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 08/01/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import "GetContatosDevice.h"

@implementation GetContatosDevice

+ (GetContatosDevice *)compartilharContatos
{
    static GetContatosDevice *getContatosCompartilhado = nil;
    
    if (!getContatosCompartilhado)
    {
        getContatosCompartilhado = [[super allocWithZone:nil] init];
    }
    return getContatosCompartilhado;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    return [self compartilharContatos];
}

- (id)init
{
    self = [super init];
    if (self)
    {
        [self permissaoAcessoContatos];
         self.contatos  = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)permissaoAcessoContatos
{
    ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error)
    {
        if (!granted)
        {
            NSLog(@"Acesso Negado");
            return;
        }
        else
        {
            [self obterContatos];
        }
                                                 
    });
}


-(void)obterContatos
{
    CFErrorRef *error = NULL;
    _addressBook      = ABAddressBookCreateWithOptions(NULL, error);
    
    if (_addressBook)
    {
        NSArray *tdContatos =  (__bridge NSArray *) ABAddressBookCopyArrayOfAllPeople(_addressBook);
        
        for (id objContato in tdContatos)
        {
            Contato *contato  = [[Contato alloc ] init];
            
            ABRecordRef    refContato     = (__bridge ABRecordRef)objContato;
            ABMultiValueRef tdEmails      = ABRecordCopyValue(refContato, kABPersonEmailProperty);
            ABMultiValueRef tdTelefones   = ABRecordCopyValue(refContato, kABPersonPhoneProperty);
           
           [contato setNome:      (__bridge NSString *)(ABRecordCopyValue(refContato, kABPersonFirstNameProperty))];
           [contato setSobrenome: (__bridge NSString *)(ABRecordCopyValue(refContato, kABPersonLastNameProperty))];
           [contato setFoto:      (__bridge_transfer NSData   *)ABPersonCopyImageDataWithFormat(refContato, kABPersonImageFormatOriginalSize)];
            
         
            //Get primeiro Email diferente da tag "Work"
            for (CFIndex i = 0; i < ABMultiValueGetCount(tdEmails); i++)
            {
                NSString *emailLabel = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex (tdEmails, i);
                
                if (![emailLabel isEqualToString:@"_$!<Work>!$_"])
                {
                    [contato setEmail:(__bridge NSString *)ABMultiValueCopyValueAtIndex(tdEmails,i)];
                     break;
                }
                
            }
            
            //Get primeiro telefone diferente da tag "Work"
            for (CFIndex i = 0; i < ABMultiValueGetCount(tdTelefones); i++)
            {
                NSString *telefoneLabel = (__bridge_transfer NSString *)ABMultiValueCopyLabelAtIndex (tdTelefones, i);
                
                if (![telefoneLabel isEqualToString:@"_$!<Work>!$_"])
                {
                    [contato setTelefone:(__bridge NSString *)ABMultiValueCopyValueAtIndex(tdTelefones,i)];
                    break;
                }

            }
            
            if ([contato getNome] && [contato getTelefone])
                [self.contatos addObject:contato];
        }
    }
}

-(NSMutableArray *)getContatos
{
    return self.contatos;
}

@end
