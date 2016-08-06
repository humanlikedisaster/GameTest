//
//  GamesViewController.h
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GamesFeedViewModel;

@interface GamesViewController : UITableViewController

- (void)setGamesViewModel: (GamesFeedViewModel *)aGamesViewModel;

@end
