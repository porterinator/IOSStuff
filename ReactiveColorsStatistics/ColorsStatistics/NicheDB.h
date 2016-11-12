//
//  NicheDB.h
//  ColorsStatistics
//
//  Created by Admin on 19/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "BaseDB.h"
#import "SQLite3Cursor.h"

#define NICHEDB_VERSION 1
#define NicheDBName @"niche.db"

@interface NicheDB : BaseDB

+ (NicheDB *)default;
-(BOOL) removeAllNiches;
-(BOOL) insertNiche: (NSDictionary *) niche;
-(SQLite3Cursor *) getNiches;

@end
