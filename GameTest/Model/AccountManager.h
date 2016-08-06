//
//  AccountManager.h
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountManager : NSObject

@property (copy ,nonatomic, readonly) NSString *userName;
@property (copy, nonatomic, readonly) NSString *userPassword;

- (void)setUserName:(NSString *)anUserName withPassword:(NSString *)anPassword;

@end
