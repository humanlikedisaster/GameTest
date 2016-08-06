//
//  GamesViewController.m
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import "GamesViewController.h"
#import "GameViewModel.h"
#import "GamesFeedViewModel.h"

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface GamesViewController ()

@property (strong, nonatomic) GamesFeedViewModel *feedViewModel;

@end

@implementation GamesViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [RACObserve(self.feedViewModel, gameWorlds) subscribeNext:^(NSArray *worldArray)
    {
        [self.tableView reloadData];
    }];
}

- (void)setGamesViewModel: (GamesFeedViewModel *)aGamesViewModel
{
    self.feedViewModel = aGamesViewModel;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"worldCell";
 
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    GameViewModel *gameViewModel = self.feedViewModel.gameWorlds[indexPath.row];
    cell.textLabel.text = gameViewModel.name;
    cell.detailTextLabel.text = gameViewModel.worldStatus;

    return cell;
}

- (NSInteger)tableView:(UITableView *)aTableView numberOfRowsInSection:(NSInteger)aSection
{
    return self.feedViewModel.gameWorlds.count;
}

@end
