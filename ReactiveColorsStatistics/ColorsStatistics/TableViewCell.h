//
//  TableViewCell.h
//  ColorsStatistics
//
//  Created by Admin on 18/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "BaseXibCell.h"

@interface TableViewCell : BaseXibCell

@property (weak, nonatomic) IBOutlet UILabel *nicheName;
@property (weak, nonatomic) IBOutlet UIProgressView *nicheStat;
@property (weak, nonatomic) IBOutlet UIImageView *nicheImage;
@property (weak, nonatomic) IBOutlet UILabel *statsLabel;


@end
