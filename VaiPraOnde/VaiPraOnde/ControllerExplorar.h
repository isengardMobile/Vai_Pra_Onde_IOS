//
//  ControllerExplorar.h
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 22/02/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>

@interface ControllerExplorar : UIViewController<GMSMapViewDelegate,CLLocationManagerDelegate,GMSPanoramaViewDelegate>

//Propriedades View
@property (nonatomic)                GMSMapView         *map;
@property (nonatomic)                GMSPanoramaView    *streetView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@property (weak, nonatomic) IBOutlet UIView             *viewMap;


//Propriedades
@property (nonatomic)                CLLocationManager  *locationManager;
@property (copy, nonatomic)          NSMutableSet       *marcacoes;

@end
