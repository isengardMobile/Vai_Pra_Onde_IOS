//
//  ControllerExplorar.m
//  VaiPraOnde
//
//  Created by Marcos Vinicius Souza Lacerda on 22/02/15.
//  Copyright (c) 2015 Marcos Lacerda. All rights reserved.
//

#import "ControllerExplorar.h"
#import <GoogleMaps/GoogleMaps.h>

@interface ControllerExplorar ()

@end

@implementation ControllerExplorar

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configLocationManager];
    [self configMap];
    [self configMarcacoes:-23.609026 :-46.697031];
    [self criarMarcacoes];
    [self configStreetView];
}

-(void)viewWillAppear:(BOOL)animated
{
   [[[self navigationController] navigationBar] setHidden:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)configLocationManager
{
    self.locationManager  = [[CLLocationManager alloc] init];
  [[self locationManager] setDelegate:self];
}

-(void)configMap
{
      self.map   = [[GMSMapView alloc] initWithFrame:CGRectMake(0,0,320, 510)];
    [[self map] setDelegate:self];
    [[self viewMap] addSubview:[self map]];
}

-(void)configStreetView
{
    self.streetView = [[GMSPanoramaView alloc] initWithFrame:CGRectMake(0,60,320, 510)];
  [[self streetView] setDelegate:self];
}

-(void)configMarcacoes : (double)latitude : (double)longitude
{
    GMSMarker *marcacao = [[GMSMarker alloc] init];
   [marcacao setPosition:CLLocationCoordinate2DMake(latitude, longitude)];
   [marcacao setAppearAnimation:kGMSMarkerAnimationPop];
   [marcacao setMap:nil];
    
   self.marcacoes = [NSMutableSet setWithObject:marcacao];
    
   // Customizar "Pin" ->  [marcacao setIcon:[UIImage imageNamed:@""]];
}

-(void)criarMarcacoes
{
    for (GMSMarker *marcacao in [self marcacoes])
    {
        marcacao.map = [self map];
    }
}

//-(UIView *)mapView:(GMSMapView *)mapView markerInfoWindow:(GMSMarker *)marker
//{
//    UIView *info = [[UIView alloc] initWithFrame:CGRectMake(0,0,200,70)];
//    [info setBackgroundColor:[UIColor redColor]];
//    
//    return info;
//}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse)
       [[self locationManager] startUpdatingLocation];
    if (status == kCLAuthorizationStatusDenied)
        [[self locationManager] requestWhenInUseAuthorization];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation             *currentLocation = [locations lastObject];
    CLLocationCoordinate2D position         = currentLocation.coordinate;
    
    GMSMarker *marcacao = [[GMSMarker alloc] init];
    [marcacao setPosition:CLLocationCoordinate2DMake(position.latitude, position.longitude)];
    [marcacao setTitle:@"Sua Posição"];
    [marcacao setIcon:[GMSMarker markerImageWithColor:[UIColor blueColor]]];
    [marcacao setMap:[self map]];
    
    [[self map] setCamera:[GMSCameraPosition cameraWithLatitude:currentLocation.coordinate.latitude
                                                      longitude:currentLocation.coordinate.longitude
                                                           zoom:17]];
    
//     CLLocationCoordinate2D panoramaNear = currentLocation.coordinate;
//    [[self streetView] moveNearCoordinate:panoramaNear];
    
    [[self locationManager] stopUpdatingLocation];
}

@end
