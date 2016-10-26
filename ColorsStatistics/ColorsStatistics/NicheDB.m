//
//  NicheDB.m
//  ColorsStatistics
//
//  Created by Admin on 19/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "NicheDB.h"
#import "Consts.h"

@interface BaseDB ()

- (id)objectForKeyPath:(NSString *)keyPath inDictionary:(NSDictionary *)dictionary;

@end

@implementation NicheDB

+ (NicheDB *)default
{
    static NicheDB * _default = nil;
    if (!_default)
    {
        @synchronized(self)
        {
            if (!_default)
            {
                BOOL isDbInitialized = [[NSFileManager defaultManager] fileExistsAtPath: [self dbFilePath]];
                _default = [[NicheDB alloc] initWithFileName: [self dbFilePath]];
                if (isDbInitialized)
                {
                    // Если версия устарела - удалить файл с базой и проинициализировать скриптом
                    if (![_default checkVersion])
                    {
                        if (![_default migrateToActual]) _default = nil;
                        
                    }
                }
                else
                {
                    if (![_default migrateToActual]) _default = nil;
                }
            }
        }
    }
    return _default;
}

- (id)initWithFileName:(NSString *)aFileName
{
    self = [super initWithFileName:aFileName];
    if (self) {
        [self executeQueryWithSQL:@"PRAGMA foreign_keys = ON;" args:nil];
    }
    return self;
}

//! @override
+ (NSString *) dbFilePath
{
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingPathComponent: [self dbFileName]];
}

//! @override
+ (NSString *) dbFileName
{
    return NicheDBName;
}

//! @override
- (NSInteger) actualUserVersion
{
    return NICHEDB_VERSION;
}

-(BOOL) removeAllNiches {
    return [self executeQueryWithSQL:@"DELETE FROM niche" args:nil];
}


-(BOOL) insertNiche: (NSDictionary *) nicheStat
{
    NSDictionary *niche = nicheStat[kNiche];
    int _id = [[self objectForKeyPath:kNicheId inDictionary:niche] intValue];
    return [self executeQueryWithSQL:@"insert into niche(id, name, resource_uri, slug, wishlist_count, nowreading_count, read_count) values (?,?,?,?,?,?,?)" args:@[[self objectForKeyPath:kNicheId inDictionary:niche],[self objectForKeyPath:kNicheName inDictionary:niche],[self objectForKeyPath:kNicheResourceUri inDictionary:niche],[self objectForKeyPath:kNicheSlug inDictionary:niche],[self objectForKeyPath:kWishListCount inDictionary:nicheStat],[self objectForKeyPath:kNowReadingCound inDictionary:nicheStat],[self objectForKeyPath:kReadCount inDictionary:nicheStat]]];
}

-(SQLite3Cursor *) getNiches
{
    return [self rawQueryWithSQL:@"select * from niche order by read_count desc" args:nil windowSize:30];
}


@end
