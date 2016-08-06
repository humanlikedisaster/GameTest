//
//  Router.h
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class AccountViewModel, RACSignal;

@interface Router : NSObject

+ (instancetype)sharedInstance;
- (RACSignal *)openGames: (AccountViewModel *)anAccountViewModel;
- (void)showError:(NSError *)anError onViewController:(UIViewController *)anViewController withTryAgainBlock:(void (^)())tryAgainBlock;

@end
