//
//  AccountManager.m
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import "AccountManager.h"
#import <SAMKeychain/SAMKeychain.h>

static NSString *kAccountManagerServiceName = @"GameFeedTestServiceNameKeychain";

@interface AccountManager()

@property (copy ,nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *userPassword;

@end

//////////////////////////////////////////////////////////////////////////////////////////////////////////

@implementation AccountManager

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];

    if (nil != self)
    {
        NSDictionary *account = (NSDictionary *)[SAMKeychain accountsForService:kAccountManagerServiceName].firstObject;
        if (nil != account)
        {
            _userName = account[@"acct"];
            _userPassword = account[@"agrp"];
        }
    }

    return self;
}

#pragma mark - Public

- (void)setUserName:(NSString *)anUserName withPassword:(NSString *)anPassword
{
    if (self.userName.length > 0)
    {
        [SAMKeychain deletePasswordForService:kAccountManagerServiceName account:self.userName];
    }

    self.userName = anUserName;
    self.userPassword = anPassword;
    [SAMKeychain setPassword:anPassword forService:kAccountManagerServiceName account:anUserName];
}

@end
