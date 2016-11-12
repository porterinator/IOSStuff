//
//  NicheModel.h
//  ColorsStatistics
//
//  Created by Admin on 19/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DataClient.h"
#import "Sqlite3Cursor.h"

@interface NicheModel : NSObject<DataClientProtocol>
{
    DataClient *dataClient;
}

- (RACSignal *)getNichesSignal;

@end
