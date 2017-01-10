//
//  RentViewModel.h
//  Jitensha
//
//  Created by Admin on 10/12/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewModelServices.h"
#import "RentViewModel.h"
#import "JitenshaPlace.h"

@interface RentViewModel : UIViewController


@property(strong, nonatomic) JitenshaPlace *currentPlace;

@property(strong, nonatomic) NSString *cardNumber;
@property(strong, nonatomic) NSString *expired;
@property(strong, nonatomic) NSString *code;
@property(strong, nonatomic) NSString *name;
@property(strong, nonatomic) RACCommand *rentCommand;
@property(strong, nonatomic) NSString * message;

- (instancetype)initWithServices:(id<ViewModelServices>)services currentPlace:(JitenshaPlace *)currentPlace;

@end
