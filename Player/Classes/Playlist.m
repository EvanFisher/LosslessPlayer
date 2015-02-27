//
//  Playlist.m
//  Player
//
//  Created by Horace Ho on 2015/02/25.
//  Copyright (c) 2015 Horace Ho. All rights reserved.
//

#import "Playlist.h"

@interface Playlist ()

@end

@implementation Playlist

+ (Playlist *)global
{
    static Playlist *sharedInstance = nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        sharedInstance = [[Playlist alloc] init];
        sharedInstance.songs = [[NSMutableArray alloc] init];
    });
    return sharedInstance;
}

@end
