//
//  NetworkManager.m
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import "NetworkManager.h"
#import "DeviceHelper.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

static NSString *kNetworkManagerFeedURL = @"http://backend1.lordsandknights.com/XYRALITY/WebObjects/BKLoginServer.woa/wa/worlds";

@interface NetworkManager () <NSURLSessionDelegate, NSURLSessionDataDelegate>

@property (strong, nonatomic) NSURLSessionDataTask *dataTask;
@property (strong, nonatomic) NSURLSession *urlSession;

@end

@implementation NetworkManager

- (instancetype)init
{
    self = [super init];
    if (nil != self)
    {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        self.urlSession = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:[NSOperationQueue new]];
    }
    return self;
}

- (RACSignal *)getFeedWithUserName:(NSString *)anUserName password:(NSString *)aPassword
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
        {
            NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kNetworkManagerFeedURL]];
            urlRequest.HTTPMethod = @"POST";
            [urlRequest setValue:anUserName forHTTPHeaderField:@"login"];
            [urlRequest setValue:aPassword forHTTPHeaderField:@"password"];
            [urlRequest setValue:[DeviceHelper deviceType] forHTTPHeaderField:@"deviceType"];
            [urlRequest setValue:[DeviceHelper deviceIdentifier] forHTTPHeaderField:@"deviceId"];
            self.dataTask = [self.urlSession dataTaskWithRequest:urlRequest completionHandler:^ (NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
                {
                    if (nil == error)
                    {
                        [subscriber sendNext:data];
                        [subscriber sendCompleted];
                    }
                    else
                    {
                        [subscriber sendError:error];
                    }
                }];
            [self.dataTask resume];

            return nil;
        }];
}

@end
