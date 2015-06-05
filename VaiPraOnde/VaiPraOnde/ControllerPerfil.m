//
//  ControllerPerfil.m
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 22/02/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import "ControllerPerfil.h"

@interface ControllerPerfil ()

@end

@implementation ControllerPerfil

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
    [[[self navigationController] navigationBar] setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
