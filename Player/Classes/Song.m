//
//  Songs.m
//  Player
//
//  Created by Horace Ho on 2015/02/24.
//  Copyright (c) 2015 Horace Ho. All rights reserved.
//

#import "Song.h"
#import "FCFileManager.h"

@implementation Song

+ (Song *)global {
    static Song *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[Song alloc] init];
    });
    return sharedInstance;
}

- (instancetype)initWithPathname:(NSString *)pathName {
    self = [super init];
    if (self) {
        self.pathName = pathName;
    }
    return self;
}

- (NSString *)songName {
    return [[self.pathName lastPathComponent] stringByDeletingPathExtension];
}

- (NSString *)fileName {
    return [self.pathName lastPathComponent];
}

- (NSURL *)songURL {
    NSURL* url = [FCFileManager urlForItemAtPath:self.pathName];
    return url;
}

@end
