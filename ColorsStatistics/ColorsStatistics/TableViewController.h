//
//  TableViewController.h
//  ColorsStatistics
//
//  Created by Admin on 18/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NicheModel.h"

@interface TableViewController : UITableViewController

@property (nonatomic, strong) NicheModel * model;
@property (weak, nonatomic) IBOutlet UIRefreshControl *refrshControl;
- (IBAction)refresh:(UIRefreshControl *)sender;

@end
