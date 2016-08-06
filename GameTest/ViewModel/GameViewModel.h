//
//  GameViewModel.h
//  GameTest
//
//  Created by hereiam on 06.08.16.
//  Copyright © 2016 TestGameView. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameViewModel : NSObject

@property (copy, nonatomic) NSString *countryCode;
@property (copy, nonatomic) NSString *language;
@property (copy, nonatomic) NSString *mapURLString;
@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *identifier;
@property (copy, nonatomic) NSString *urlString;

@property (copy, nonatomic) NSString *worldStatus;
@property (copy, nonatomic) NSString *worldIdentifier;

@end
