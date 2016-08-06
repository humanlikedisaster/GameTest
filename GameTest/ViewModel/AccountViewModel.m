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

+ (BOOL)textIsValidEmailFormat:(NSString *)text
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:text];
}

- (instancetype)init
{
    self = [super init];
    if (nil != self)
    {
        self.accountManager = [[AccountManager alloc] init];
    }
    return self;
}

- (void)setCreditionals:(NSString *)anUserName password:(NSString *)aPassword
{
    self.accountManager.userName = anUserName;
    self.accountManager.userPassword = aPassword;
}

- (NSString *)userName
{
    return self.accountManager.userName;
}

- (NSString *)password
{
    return self.accountManager.userPassword;
}

@end
