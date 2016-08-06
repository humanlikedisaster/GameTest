//
//  FeedViewModel.m
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import "AccountViewModel.h"
#import "AccountManager.h"

@interface AccountViewModel ()

@property (strong, nonatomic) AccountManager *accountManager;

@end

@implementation AccountViewModel

#pragma mark - Helper Method

+ (BOOL)textIsValidEmailFormat:(NSString *)text
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:text];
}

#pragma mark - Lifecycle

- (instancetype)init
{
    self = [super init];
    if (nil != self)
    {
        self.accountManager = [[AccountManager alloc] init];
    }
    return self;
}

#pragma mark - Public

- (void)setCreditionals:(NSString *)anUserName password:(NSString *)aPassword save:(BOOL)aSave
{
    [self.accountManager setUserName:anUserName withPassword:aPassword save:aSave];
}

- (void)logout
{
    [self.accountManager logout];
}

#pragma mark - Getters

- (NSString *)userName
{
    return self.accountManager.userName;
}

- (NSString *)password
{
    return self.accountManager.userPassword;
}

@end
