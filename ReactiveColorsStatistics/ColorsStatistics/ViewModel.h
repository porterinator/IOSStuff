//
//  ViewModel.h
//  ColorsStatistics
//
//  Created by Admin on 12/11/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "SQLite3Cursor.h"
#import "NicheModel.h"

@interface ViewModel : NSObject

-(instancetype) initWithNicheModel: (NicheModel *) nicheModel;

@property (strong, nonatomic) SQLite3Cursor *niches;
@property (strong, nonatomic) RACCommand *getStatistics;
@property (strong, nonatomic) RACSignal *connectionErrors;

@end
