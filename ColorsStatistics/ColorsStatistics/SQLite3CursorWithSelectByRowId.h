//
//  SQLite3CursorWithSelectByRowId.h
//  ColorsStatistics
//
//  Created by Admin on 18/10/16.
//  Copyright © 2016 Admin. All rights reserved.


#import <Foundation/Foundation.h>
#import "SQLite3Cursor.h"

/** Курсор с заполнением окна селектом по rowid */
@interface SQLite3CursorWithSelectByRowId : SQLite3Cursor
{
    NSMutableArray * rowids;
}
@property (nonatomic, strong) NSString * selectByRowIdSQLString;
@property (nonatomic, readonly) NSArray * rowids;

@end
