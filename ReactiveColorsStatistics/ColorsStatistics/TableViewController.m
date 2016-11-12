//
//  TableViewController.m
//  ColorsStatistics
//
//  Created by Admin on 18/10/16.
//  Copyright © 2016 Admin. All rights reserved.
//

#import "TableViewController.h"
#import "TableViewCell.h"
#import "Consts.h"


@interface TableViewController ()

@property (weak, nonatomic) ViewModel *viewModel;

@end

@implementation TableViewController

- (instancetype) initWithViewModel: (ViewModel *)viewModel
{
    self = [super init];
    if (self) {
        _viewModel = viewModel;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        
    }
    return self;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void) setViewModel: (ViewModel *) viewModel
{
    _viewModel = viewModel;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.contentInset = UIEdgeInsetsMake(44,0,0,0);
    self.tableView.allowsSelection = NO;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 150.0;
    [self bindViewModel];
    [self.viewModel.getStatistics execute:nil];
}

-(void) bindViewModel
{
    [[RACObserve(self.viewModel, niches) deliverOn:[RACScheduler mainThreadScheduler]] subscribeNext:^(id x) {
        [self.tableView reloadData];
        [self.refrshControl endRefreshing];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _viewModel.niches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TableViewCell class])];
    if (!cell) {
        cell = [TableViewCell item];
        [cell setUp];
    }
    
    NSDictionary *niche = [_viewModel.niches itemAtIndex:indexPath.row];
    [cell updateFromData:niche];
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return NO;
}


-(void) tableView:(UITableView *) tableView willDisplayCell:(UITableViewCell *) cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *tvc = (TableViewCell *)cell;
    UIProgressView *progressView = tvc.nicheStat;

    NSDictionary *niche = [_viewModel.niches itemAtIndex:indexPath.row];
    int nowReadingCount = [niche[kWishListCount] intValue];
    int readingCount = [niche[kReadCount] intValue];
    
    float progress = 0;
    if (readingCount > 0) {
        progress = readingCount / 100.0f;
    } else {
        progress = nowReadingCount / 100.0f;
    }
    [progressView setProgress:progress animated:YES];
}

- (IBAction)refresh:(UIRefreshControl *)sender
{
    [_viewModel.getStatistics execute:nil];
}
@end
