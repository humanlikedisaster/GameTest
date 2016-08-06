//
//  ViewController.m
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import "LoginViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "AccountViewModel.h"
#import "Router.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextView;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIView *greyView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) AccountViewModel *accountViewModel;

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.accountViewModel = [[AccountViewModel alloc] init];

    RACSignal *emailPasswordSignal = [RACSignal combineLatest:
        @[self.emailTextView.rac_textSignal, self.passwordTextView.rac_textSignal]
        reduce:^id(NSString *emailText, NSString *passwordText)
        {
            return @([AccountViewModel textIsValidEmailFormat:emailText] && passwordText.length > 0);
        }];
        
    RAC(self.loginButton, enabled) = emailPasswordSignal;
    [[self.loginButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x)
    {
        [self.accountViewModel setCreditionals:self.emailTextView.text password:self.passwordTextView.text];
        [self login];
    }];

    BOOL isLogined = (self.accountViewModel.userName.length > 0 && self.accountViewModel.password.length > 0);
    if (isLogined)
    {
        self.emailTextView.text = self.accountViewModel.userName;
        [self.emailTextView sendActionsForControlEvents:UIControlEventEditingChanged];
        self.passwordTextView.text = self.accountViewModel.password;
        [self.passwordTextView sendActionsForControlEvents:UIControlEventEditingChanged];
        [self login];
    }
}


- (void)login
{
    self.greyView.hidden = NO;
    [self.activityIndicator startAnimating];
    [[[Router sharedInstance] openGames: self.accountViewModel] subscribeNext:^(id x)
    {
        self.greyView.hidden = YES;
        [self.activityIndicator stopAnimating];
    }
    error:^(NSError *error)
    {
        self.greyView.hidden = YES;
        [self.activityIndicator stopAnimating];
        __block __weak LoginViewController *weakSelf = self;
        [[Router sharedInstance] showError:error onViewController:self withTryAgainBlock:^
        {
            [weakSelf login];
        }];
    }];
}

@end
