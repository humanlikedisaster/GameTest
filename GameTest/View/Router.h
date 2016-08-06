//
//  Router.h
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AccountViewModel;

@interface Router : NSObject

+ (instancetype)sharedInstance;
- (void)openGames: (AccountViewModel *)anAccountViewModel;

@end
