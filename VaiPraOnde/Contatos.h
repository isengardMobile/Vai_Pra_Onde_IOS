//
//  Contatos.h
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 08/01/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Contatos : NSManagedObject

@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSString * sobrenome;
@property (nonatomic, retain) NSNumber * mobilePhone;
@property (nonatomic, retain) NSData   * foto;
@property (nonatomic, retain) NSString * email;

@end
