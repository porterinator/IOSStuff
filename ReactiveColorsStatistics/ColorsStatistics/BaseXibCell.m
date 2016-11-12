//
//  BaseXibCell.m
//  ColorsStatistics
//
//  Created by Admin on 18/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "BaseXibCell.h"

@implementation BaseXibCell

@dynamic width;

+ (instancetype) item
{
    NSArray * nibObjects = [[NSBundle mainBundle] loadNibNamed: [self xibName] owner:self options:nil];
    BaseXibCell * cell = [nibObjects objectAtIndex: [self xibIndex]];
    [cell setUp];
    return cell;
}

+ (BaseXibCell *)itemWithData:(NSDictionary *)data width:(CGFloat)width
{
    BaseXibCell * item = [BaseXibCell item];
    item.width = width;
    [item updateFromData:data];
    return item;
}

- (void) setUp
{
    //
}

+ (NSInteger) xibIndex
{
    return 0;
}

+ (NSString *) xibName
{
    return NSStringFromClass([self class]);
}

+ (NSString *)reuseIdentifier
{
    return NSStringFromClass([self class]);
}

+ (CGFloat)itemHeightForData:(NSDictionary *)itemData width:(CGFloat)width
{
    return 0.0f;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
}

- (void)sizeToFit
{
    //
}

- (void)updateFromData:(NSDictionary *)data
{
    [self sizeToFit];
}

#pragma mark - Properties
- (void)setWidth:(CGFloat)width
{
    CGRect selfFrame = self.frame;
    selfFrame.size.width = width;
    self.frame = selfFrame;
}

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

@end
