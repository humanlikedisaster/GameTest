//
//  GameViewModel.h
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AccountViewModel;

@interface GameFeedStatus : NSObject

@property (assign, nonatomic) BOOL isLoaded;
@property (strong, nonatomic) NSError *error;

@end

//////////////////////////////////////////////////////////////////////////////////////////////////////////

@interface GamesFeedViewModel : NSObject

@property (strong, nonatomic, readonly) NSMutableArray *gameWorlds;
@property (strong, nonatomic, readonly) GameFeedStatus *status;

- (instancetype)initWithAccountViewModel: (AccountViewModel *)anAccountViewModel;

@end
