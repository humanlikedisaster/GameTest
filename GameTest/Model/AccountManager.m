//
//  AccountManager.m
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import "AccountManager.h"
#import <SAMKeychain/SAMKeychain.h>

static NSString *kAccountManagerServiceName = @"GameTestServiceNameKeychain";

@interface AccountManager()

@property (copy ,nonatomic) NSString *userName;
@property (copy, nonatomic) NSString *userPassword;

@end

@implementation AccountManager

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

- (void)setUserName:(NSString *)anUserName withPassword:(NSString *)anPassword
{
    self.userName = anUserName;
    self.userPassword = anPassword;
    [SAMKeychain setPassword:anPassword forService:kAccountManagerServiceName account:anUserName];
}

@end
