//
//  Contato.h
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 10/01/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface Contato : NSObject

@property (strong,nonatomic,getter=getNome)       NSString   *nome;
@property (strong,nonatomic,getter=getSobrenome)  NSString   *sobrenome;
@property (strong,nonatomic,getter=getEmail)      NSString   *email;
@property (strong,nonatomic,getter=getFoto)       NSData     *foto;
@property (strong,nonatomic,getter=getTelefone)   NSString   *telefone;

@end
