//
//  NetworkManager.h
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RACSignal;

@interface NetworkManager : NSObject

- (RACSignal *)getFeedWithUserName:(NSString *)anUserName password:(NSString *)aPassword;

@end
