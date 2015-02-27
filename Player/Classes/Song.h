//
//  Songs.h
//  Player
//
//  Created by Horace Ho on 2015/02/24.
//  Copyright (c) 2015 Horace Ho. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Song : NSObject

- (instancetype)initWithPathname:(NSString *)pathName;

+ (Song *)global;

@property (nonatomic, copy) NSString *pathName;

- (NSString *)songName;
- (NSString *)fileName;
- (NSURL *)songURL;

@end
