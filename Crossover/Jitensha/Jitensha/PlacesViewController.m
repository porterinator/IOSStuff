//
//  PlacesViewController.m
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "PlacesViewController.h"
#import "RentController.h"
#import "RentViewModel.h"
#import "ViewModelServicesImpl.h"

@interface PlacesViewController ()

@property (weak, nonatomic) PlacesViewModel *viewModel;

@end

@implementation PlacesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.delegate = self;
    [self bindViewModel];
    [self.viewModel.getPlaces execute:nil];
}

- (void) bindViewModel {
    [[RACObserve(self.viewModel, places) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        JitenshaPlace *place;
        for (int i = 0; i < [_viewModel.places count]; i++) {
            place = _viewModel.places[i];
            CLLocationCoordinate2D position = CLLocationCoordinate2DMake(place.lat , place.lng);
            GMSMarker *bicyle = [GMSMarker markerWithPosition:position];
            bicyle.title = place.name;
            bicyle.map = _mapView;
            bicyle.userData = place;
        }
        GMSCameraPosition *tokyo = [GMSCameraPosition cameraWithLatitude:place.lat
                                                                longitude:place.lng
                                                                     zoom:10];
        [_mapView setCamera:tokyo];
    }];
    
    [self.viewModel.getPlaces.errors subscribeNext:^(NSError *error) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"There was a problem getting places from Jitensha.";
        hud.margin = 10.f;
        hud.yOffset = 150.f;
        hud.removeFromSuperViewOnHide = YES;
        
        [hud hideAnimated:YES afterDelay:3];
    }];
}

- (void) setViewModel:(PlacesViewModel *) placesViewModel {
    _viewModel = placesViewModel;
}

- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker {
    JitenshaPlace *place = (JitenshaPlace *)marker.userData;
    if (self.viewModel.selectedPlace != place) {
        self.viewModel.selectedPlace = place;
        return NO;
    } else {
        [self performSegueWithIdentifier:@"rentBicycle" sender:self];
        return YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"rentBicycle"]) {
        RentController *rentController = (RentController *) segue.destinationViewController;
        RentViewModel *rentViewModel = [[RentViewModel alloc] initWithServices:[ViewModelServicesImpl sharedInstance] currentPlace:self.viewModel.selectedPlace];
        [rentController setViewModel: rentViewModel];
    }
}

@end
