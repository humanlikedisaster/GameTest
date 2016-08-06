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
        [[Router sharedInstance] openGames: self.accountViewModel];
    }];
}


@end
