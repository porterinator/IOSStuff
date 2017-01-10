//
//  PlacesViewController.h
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlacesViewModel.h"
#import <GoogleMaps/GoogleMaps.h>
#import "MBProgressHUD.h"

@interface PlacesViewController : UIViewController<GMSMapViewDelegate>

@property (weak, nonatomic) IBOutlet GMSMapView *mapView;
- (void) setViewModel:(PlacesViewModel *) placesViewModel;

@end
