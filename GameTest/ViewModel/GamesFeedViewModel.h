//
//  GameViewModel.h
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AccountViewModel;

@interface GamesFeedViewModel : NSObject

- (instancetype)initWithAccountViewModel: (AccountViewModel *)anAccountViewModel;

@end
