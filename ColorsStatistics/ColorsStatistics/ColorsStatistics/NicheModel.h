//
//  NicheModel.h
//  ColorsStatistics
//
//  Created by Admin on 19/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataClient.h"
#import "Sqlite3Cursor.h"

@interface NicheModel : NSObject
{
    DataClient *dataClient;
    SQLite3Cursor *nicheCursor;
}

@property (nonatomic, readonly) NSInteger count;

- (NSMutableDictionary *)objectAtIndexedSubscript:(NSUInteger)idx;

-(void) getNiches:(void(^)())success
          failure:(void (^)(NSError * error))failure;

@end
