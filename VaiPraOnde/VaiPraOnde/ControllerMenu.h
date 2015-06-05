//
//  ControllerMenu.h
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 20/02/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ControllerLogin.h"

@interface ControllerMenu : UITableViewController

//Propriedades
@property (nonatomic)                NSArray      *secoes;
@property (nonatomic,getter=getNome) UILabel      *nomeUser;
@property (nonatomic,getter=getFoto) UIImageView  *fotoUser;

@end
