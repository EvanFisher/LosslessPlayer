//
//  Playlist.h
//  Player
//
//  Created by Horace Ho on 2015/02/25.
//  Copyright (c) 2015 Horace Ho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Song.h"

@interface Playlist : NSObject

+ (Playlist *)global;

@property (nonatomic, strong) NSMutableArray *songs;

@end
