//
//  SQLite3CursorWithSelectByRowId.m
//  ColorsStatistics
//
//  Created by Admin on 18/10/16.
//  Copyright © 2016 Admin. All rights reserved.


#import "SQLite3CursorWithSelectByRowId.h"
#import "SQLite3Query.h"
#import "SQLite3CursorWindow.h"
#import "SQLite3Database.h"

@interface SQLite3Cursor ()

- (void)updateCountIfNeeded;
- (void)fillWindow:(SQLite3CursorWindow *)aWindow withStartPosition:(NSInteger)startPosition;

@end

@implementation SQLite3CursorWithSelectByRowId

@synthesize rowids = rowids;

#pragma mark - Class life cycle
- (id)initWithSQLite3Database:(SQLite3Database *)dataBase sqlite3Query:(SQLite3Query *)aQuery windowSize:(NSUInteger)size
{
    self = [super initWithSQLite3Database:dataBase sqlite3Query:aQuery windowSize:size];
    if (self) {
        rowids = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - Private methods
- (void)storeRowidFromQuery:(SQLite3Query *)aQuery
{
    [rowids addObject:[aQuery numberForColumnName:@"rowid"]];
}

#pragma mark - Overriden methods
- (void)updateCount
{
    count = [query getRowNumber];
    while ([query step]) {
        [self storeRowidFromQuery:query];
        count++;
    }
    [query reset];
}

- (void)fillWindowByRowId:(SQLite3CursorWindow *)aWindow startPosition:(NSInteger)startPosition
{
    if (startPosition < 0) {
        startPosition = 0;
    }
    
    aWindow.startPosition = startPosition;
    NSInteger realWindowSize = startPosition + aWindow.size > count ? count - startPosition : aWindow.size;
    NSArray * args = [rowids subarrayWithRange:NSMakeRange(startPosition, realWindowSize)];
    NSString * sql = [NSString stringWithFormat:_selectByRowIdSQLString, [args componentsJoinedByString:@","], nil];
    SQLite3Query * selectByRowIdQuery = [db queryWithSQL:sql args:nil];
    while ([selectByRowIdQuery step]) {
        [window addItem:[selectByRowIdQuery resultDictionary]];
    }
}

//! @override
- (void)fillWindow:(SQLite3CursorWindow *)aWindow withStartPosition:(NSInteger)startPosition
{
#ifdef DEBUG
    NSDate * startDate = [NSDate date];
#endif
    
    [aWindow clear];
    [self updateCountIfNeeded];
    [self fillWindowByRowId:aWindow startPosition:startPosition];

#ifdef DEBUG
    NSLog(@"fill window time : %f startPosition : %d", -[startDate timeIntervalSinceNow], startPosition);
#endif
}

//! @override
- (NSMutableDictionary *)singleItemAtIndex:(NSUInteger)index
{
    if ([window containsItemWithIndex:index]) {
        return [window itemAtIndex:index];
    } else {
        NSString * sql = [NSString stringWithFormat:_selectByRowIdSQLString, [rowids[index] stringValue], nil];
        SQLite3Query * selectByRowIdQuery = [db queryWithSQL:sql args:nil];
        if ([selectByRowIdQuery step]) {
            return [selectByRowIdQuery resultDictionary];
        } else {
            return nil;
        }
    }
}

@end
