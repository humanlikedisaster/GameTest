//
//  FeedViewModel.h
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountViewModel : NSObject

@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy, readonly) NSString *password;

+ (BOOL)textIsValidEmailFormat:(NSString *)text;
- (void)setCreditionals:(NSString *)anUserName password:(NSString *)aPassword save:(BOOL)aSave;
- (void)logout;

@end
