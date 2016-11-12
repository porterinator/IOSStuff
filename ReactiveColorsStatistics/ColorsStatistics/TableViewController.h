//
//  TableViewController.h
//  ColorsStatistics
//
//  Created by Admin on 18/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NicheModel.h"
#import "ViewModel.h"

@interface TableViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UIRefreshControl *refrshControl;
- (IBAction)refresh:(UIRefreshControl *)sender;
- (instancetype) initWithViewModel: (ViewModel *)viewModel;
- (void) setViewModel: (ViewModel *) viewModel;
@end
