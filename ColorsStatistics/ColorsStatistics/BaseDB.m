//
//  BaseDB.m
//  ColorsStatistics
//
//  Created by Admin on 19/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "BaseDB.h"

#define AttachDBSQLString @"ATTACH '%s' AS %@;"
#define DetachDBSQLString @"DETACH DATABASE %@;"

@interface SQLite3Database ()

- (void) loadCustomFunctional;

@end

@implementation BaseDB

#pragma mark - Private methods
- (id)objectForKey:(NSString *)key inDictionary:(NSDictionary *)dictionary
{
    return [dictionary objectForKey:key] ?: [NSNull null];
}

- (id)objectForKeyPath:(NSString *)keyPath inDictionary:(NSDictionary *)dictionary
{
    return [dictionary valueForKeyPath:keyPath] ?: [NSNull null];
}

/** Получает актуальную версию базы в коде */
- (NSInteger) actualUserVersion
{
    return 0;
}

/** Проверяет текущую версию базы и сравнивает с актуальной в коде */
- (BOOL) checkVersion
{
    NSInteger userVersion = [self userVersion];
    NSLog(@"Check versions %@: userVersion %d, actualVersion: %d", [self.class dbFileName], userVersion, [self actualUserVersion]);
    return userVersion == [self actualUserVersion];
}

/** Устанавливает текущую версию базы */
- (BOOL) setUserVersionTo: (NSInteger) version
{
    return [self executeQueryWithSQL: [NSString stringWithFormat:@"PRAGMA user_version = %d;", version]
                                args: nil];
}

- (void)loadCustomFunctional
{
    [super loadCustomFunctional];
    
}

- (void) dealloc
{
    
}

#pragma mark - Public methods

- (BOOL) migrateToActual
{
    NSLog(@"Миграция версии базы %@: v%d -> v%d", [self.class dbFileName], [self userVersion], [self actualUserVersion]);
    for (int version = [self userVersion] + 1; version <= [self actualUserVersion]; version++)
    {
        NSString *migrateVersionScriptPath = [[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%@.%d", [self.class dbFileName], version] ofType:@"sql"];
        NSError * migrateVersionScriptFileError = nil;
        NSString * migrateSqlString = [NSString stringWithContentsOfFile: migrateVersionScriptPath
                                                                encoding: NSUTF8StringEncoding
                                                                   error: &migrateVersionScriptFileError];
        if (!migrateVersionScriptFileError)
        {
            NSMutableArray * migrateSqlStatements = [NSMutableArray new];
            NSArray * parsedStatements = [migrateSqlString componentsSeparatedByString: @";\n"];
            for (NSString * statement in parsedStatements)
            {
                if (![statement isEqualToString:@""])
                    [migrateSqlStatements addObject: statement];
            }
            NSLog(@"Миграция версии базы %@: v%d -> v%d: %@", [self.class dbFileName], [self userVersion], version, migrateSqlStatements);
            [self beginTransaction];
            for (NSString * migrateSqlStatement in migrateSqlStatements)
            {
                if (![self executeQueryWithSQL: migrateSqlStatement args: nil])
                {
                    [self rollbackTransaction];
                    NSLog(@"Ошибка при выполенении миграции!!! Выполнение скрипта завершилось с ошибкой: %@", migrateSqlStatement);
                    return NO;
                }
            }
            [self setUserVersionTo: version];
            [self commitTransaction];
        }
        else
        {
            NSLog(@"Ошибка при выполенении миграции %@. Не найден миграционный файл %@",
                       [migrateVersionScriptFileError localizedDescription],
                       migrateVersionScriptPath);
            return NO;
        }
    }
    NSLog(@"Миграция успешно завершена.");
    return YES;
}

- (BOOL)attachDB:(BaseDB *)database
{
    if (!database) {
        return NO;
    }
    NSString * sql = [NSString stringWithFormat:AttachDBSQLString, [[database.class dbFilePath] UTF8String], [[database.class dbFileName] stringByDeletingPathExtension]];
    return [self executeQueryWithSQL:sql args:nil];
}

- (BOOL)detachDB:(BaseDB *)database
{
    if (!database) {
        return NO;
    }
    NSString * sql = [NSString stringWithFormat:DetachDBSQLString, [[database.class dbFileName] stringByDeletingPathExtension]];
    return [self executeQueryWithSQL:sql args:nil];
}

+ (NSString *) dbFilePath
{
    return nil;
}

+ (NSString *) dbFileName
{
    return nil;
}

@end
