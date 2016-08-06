//
//  FeedViewModel.h
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AccountViewModel : NSObject

+ (BOOL)textIsValidEmailFormat:(NSString *)text;
- (void)setCreditionals:(NSString *)anUserName password:(NSString *)aPassword;

@property (nonatomic, copy, readonly) NSString *userName;
@property (nonatomic, copy, readonly) NSString *password;

@end
