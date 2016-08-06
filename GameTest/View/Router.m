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

#import <ReactiveCocoa/ReactiveCocoa.h>

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
        router.navigationController = (UINavigationController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    });
    return router;
}

- (RACSignal *)openGames:(AccountViewModel *)anAccountViewModel
{
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
    {
        GamesFeedViewModel *gamesFeedViewModel = [[GamesFeedViewModel alloc] initWithAccountViewModel:anAccountViewModel];

        [[[[RACObserve(gamesFeedViewModel.status, isLoaded) skip:1] take:1] deliverOnMainThread]
        subscribeNext:^(NSNumber *isLoaded)
        {
            if ([isLoaded boolValue])
            {
                UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                GamesViewController *gamesViewController = (GamesViewController *)[storyBoard instantiateViewControllerWithIdentifier:@"GamesViewController"];
                [gamesViewController setGamesViewModel:gamesFeedViewModel];
                [self.navigationController pushViewController:gamesViewController animated:YES];
                [subscriber sendNext:gamesViewController];
                [subscriber sendCompleted];
            }
            else
            {
                [subscriber sendError:gamesFeedViewModel.status.error];
            }
        }];
        return nil;
    }] deliverOnMainThread];

}

- (void)showError:(NSError *)anError onViewController:(UIViewController *)anViewController withTryAgainBlock:(void (^)())tryAgainBlock
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Network error" message:@"There is network error, please try again!" preferredStyle:UIAlertControllerStyleAlert];

    [alertController addAction:[UIAlertAction actionWithTitle:@"Try Again" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
    {
        tryAgainBlock();
    }]];
    
    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDestructive handler:nil]];

    [anViewController presentViewController:alertController animated:YES completion:nil];
}

@end
