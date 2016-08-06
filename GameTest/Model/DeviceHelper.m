//
//  DeviceHelper.m
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import "DeviceHelper.h"
#import <UIKit/UIKit.h>

@implementation DeviceHelper

+ (NSString *)deviceType
{
    return [NSString stringWithFormat:@"%@ - %@ %@", [[UIDevice currentDevice] model], [[UIDevice currentDevice] systemName], [[UIDevice currentDevice] systemVersion]];
}

+ (NSString *)deviceIdentifier
{
    return [[NSUUID UUID] UUIDString];
}

@end
