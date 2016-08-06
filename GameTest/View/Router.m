//
//  Router.m
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import "Router.h"
#import "LoginViewController.h"
#import "AccountViewModel.h"

#import "GamesViewController.h"
#import "GamesFeedViewModel.h"

@interface Router ()

@property (weak, nonatomic) UINavigationController *navigationController;

@end

@implementation Router

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    static Router *router = nil;
    dispatch_once(&onceToken, ^
    {
        router = [[Router alloc] init];
        router.navigationController = [UIApplication sharedApplication].keyWindow.rootViewController.navigationController;
    });
    return router;
}

- (void)openGames: (AccountViewModel *)anAccountViewModel
{
    GamesFeedViewModel *gamesFeedViewModel = [[GamesFeedViewModel alloc] initWithAccountViewModel:anAccountViewModel];
}

@end
