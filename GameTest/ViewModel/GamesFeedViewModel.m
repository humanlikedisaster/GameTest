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

#import <ReactiveCocoa/ReactiveCocoa.h>

@interface GamesFeedViewModel ()

@property (strong, nonatomic) AccountViewModel *accountViewModel;
@property (strong, nonatomic) NetworkManager *networkManager;

@end

@implementation GamesFeedViewModel

- (instancetype)initWithAccountViewModel: (AccountViewModel *)anAccountViewModel
{
    self = [super init];
    if (nil != self)
    {
        self.accountViewModel = anAccountViewModel;
        self.networkManager = [[NetworkManager alloc] init];
        [self getGamesFeed];
    }
    return self;
}

- (void)getGamesFeed
{
    RACSignal *networkSignal = [self.networkManager getFeedWithUserName:self.accountViewModel.userName password:self.accountViewModel.password];
    [networkSignal subscribeNext:^(id x)
    {
        NSLog(@"%@", x);
    }];
}

@end
