//
//  GameViewModel.m
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import "GamesFeedViewModel.h"
#import "NetworkManager.h"
#import "AccountViewModel.h"
#import "GameViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation GameFeedStatus

@end

//////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface GamesFeedViewModel ()

@property (strong, nonatomic) AccountViewModel *accountViewModel;
@property (strong, nonatomic) NetworkManager *networkManager;
@property (strong, nonatomic) GameFeedStatus *status;

@property (strong, nonatomic) NSMutableArray *gameWorlds;

@end

@implementation GamesFeedViewModel

#pragma mark - Lifecycle

- (instancetype)initWithAccountViewModel: (AccountViewModel *)anAccountViewModel
{
    self = [super init];
    if (nil != self)
    {
        self.accountViewModel = anAccountViewModel;
        self.networkManager = [[NetworkManager alloc] init];
        self.gameWorlds = [NSMutableArray array];
        self.status = [[GameFeedStatus alloc] init];
        self.status.isLoaded = NO;
        [self getGamesFeed];
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"GamesFeedViewModel deallocated");
    [self.accountViewModel logout];
}

#pragma mark - Private

- (void)getGamesFeed
{
    RACSignal *networkSignal = [self.networkManager getFeedWithUserName:self.accountViewModel.userName password:self.accountViewModel.password];
    [networkSignal subscribeNext:^(NSDictionary *pListDictionary)
    {
        NSArray *worldPList = pListDictionary[@"allAvailableWorlds"];
        for (NSDictionary *world in worldPList)
        {
            GameViewModel *gameViewModel = [[GameViewModel alloc] init];

            gameViewModel.countryCode = world[@"country"];
            gameViewModel.identifier = world[@"id"];
            gameViewModel.language = world[@"language"];
            gameViewModel.mapURLString = world[@"mapURL"];
            gameViewModel.urlString = world[@"url"];
            gameViewModel.name = world[@"name"];
            gameViewModel.worldStatus = world[@"worldStatus"][@"description"];
            gameViewModel.worldIdentifier = world[@"worldStatus"][@"id"];

            [self.gameWorlds addObject:gameViewModel];
        }
        self.status.error = nil;
        self.status.isLoaded = YES;
    }
    error:^(NSError *error)
    {
        self.status.error = error;
        self.status.isLoaded = NO;
    }];
}

@end
