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

#pragma mark - Lifecycle

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

#pragma mark - Public

- (RACSignal *)getFeedWithUserName:(NSString *)anUserName password:(NSString *)aPassword
{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber)
        {
            NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:kNetworkManagerFeedURL]];
            urlRequest.HTTPMethod = @"POST";
            NSString *httpBody = [NSString stringWithFormat:@"login=%@&password=%@&deviceType=%@&deviceType=&@&deviceId=%@",
                anUserName, aPassword, [DeviceHelper deviceType], [DeviceHelper deviceIdentifier]];
            [urlRequest setHTTPBody:[httpBody dataUsingEncoding:NSUTF8StringEncoding]];
            self.dataTask = [self.urlSession dataTaskWithRequest:urlRequest completionHandler:^ (NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error)
            {
                if (nil == error)
                {
                    NSError *parseError;
                    NSPropertyListFormat format;

                    NSDictionary* plist = [NSPropertyListSerialization propertyListWithData:data options:NSPropertyListImmutable format:&format error:&parseError];

                    if (nil != plist[@"allAvailableWorlds"])
                    {
                        [subscriber sendNext:plist];
                        [subscriber sendCompleted];
                    }
                    else
                    {
                        [subscriber sendError:[NSError errorWithDomain:@"download.worlds.error" code:-999 userInfo:plist]];
                    }
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
