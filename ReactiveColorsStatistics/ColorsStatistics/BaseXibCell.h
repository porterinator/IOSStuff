//
//  BaseXibCell.h
//  ColorsStatistics
//
//  Created by Admin on 18/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseXibCell : UITableViewCell

@property (nonatomic) CGFloat width;

+ (instancetype) item;
+ (BaseXibCell *)itemWithData:(NSDictionary *)data width:(CGFloat)width;
- (void) setUp;
+ (NSString *)reuseIdentifier;
+ (CGFloat)itemHeightForData:(NSDictionary *)itemData width:(CGFloat)width;

- (void)updateFromData:(NSDictionary *)data;

@end
