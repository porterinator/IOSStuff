//
//  BaseDB.h
//  ColorsStatistics
//
//  Created by Admin on 19/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "SQLite3Database.h"

/** Базовый класс для всех баз данных */
@interface BaseDB : SQLite3Database

/** Полный путь к файлу с базой данных */
+ (NSString *) dbFilePath;

/** Имя файла базы данных */
+ (NSString *) dbFileName;

/** Выполняет миграцию базы до актуальной версии. Пример формата имени файла: local.db.1.sql */
- (BOOL) migrateToActual;

/** Приаттачивает к себе указанную бд */
- (BOOL)attachDB:(BaseDB *)database;

/** Отключает указанную бд */
- (BOOL)detachDB:(BaseDB *)database;

- (BOOL) checkVersion;

@end
