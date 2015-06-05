//
//  ContatosDevice.h
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 08/01/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import "Contato.h"

@interface GetContatosDevice : NSObject

//Propriedade
@property (nonatomic, readonly) ABAddressBookRef addressBook;
@property (nonatomic)           NSMutableArray   *contatos;

//Metodos
-(NSMutableArray *)getContatos;

//Método Singletons
+ (GetContatosDevice *)compartilharContatos;
+ (id)allocWithZone:(struct _NSZone *)zone;

@end
