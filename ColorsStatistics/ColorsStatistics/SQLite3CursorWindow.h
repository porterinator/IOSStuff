//
//  SQLite3CursorWindow.h
//  ColorsStatistics
//
//  Created by Admin on 18/10/16.
//  Copyright © 2016 Admin. All rights reserved.


#import <Foundation/Foundation.h>

/** Окно курсора */
@interface SQLite3CursorWindow : NSObject
{
@protected
    /** Непосредственно окно, элементы выборки */
    NSMutableArray * window;
    
    /** Размер окна */
    NSUInteger size;
    
    /** Начальная позиция окна в выборке */
    NSInteger startPosition;
}
@property (nonatomic, readonly, getter = getCount) NSUInteger count;
@property (nonatomic, assign) NSInteger startPosition;
@property (nonatomic, readonly) NSUInteger size;

/** Инициализатор с размером окна */
- (id)initWithWindowSize:(NSUInteger)size;

/** Добавить элемент выборки в окно */
- (void)addItem:(NSMutableDictionary *)item;

/** Возвращает элемент по его индексу */
- (NSMutableDictionary *)itemAtIndex:(NSInteger)index;

/** Очистка окна */
- (void)clear;

/** Содержит ли элемент с указанным индексом */
- (BOOL)containsItemWithIndex:(NSInteger)index;

@end
