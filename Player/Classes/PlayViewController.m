//
//  PlayViewController.m
//  Player
//
//  Created by Horace Ho on 2015/02/24.
//  Copyright (c) 2015 Horace Ho. All rights reserved.
//

#import "ORGMEngine.h"
#import "Song.h"
#import "PlayViewController.h"

@interface PlayViewController () <ORGMEngineDelegate>

@property (strong, nonatomic) ORGMEngine* player;
@property (strong, nonatomic) IBOutlet UIButton *playButton;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UISlider *timeSlider;
@property (strong, nonatomic) NSTimer* refreshTimer;

@end

@implementation PlayViewController

- (ORGMEngine *)player {
    if (_player == nil) {
        self.player = [[ORGMEngine alloc] init];
        _player.delegate = self;
    }
    return _player;
}

- (NSString *)secondToTime:(double)seconds {
    NSInteger ti = seconds;
    NSInteger ss = ti % 60;
    NSInteger mm = (ti / 60) % 60;
    NSInteger hh = (ti / 3600);
    NSString *timeString;
    if (hh > 0) {
        timeString = [NSString stringWithFormat:@"%02ld:%02ld:%02ld", (long)hh, (long)mm, (long)ss];
    } else {
        timeString = [NSString stringWithFormat:@"%02ld:%02ld", (long)mm, (long)ss];
    }
    return timeString;
}

- (void)refreshUI {
    // View title
    self.title = Song.global.songName;

    // Play button label
    NSString *playLabelText = (self.player.currentState == ORGMEngineStatePlaying)  ? @"Pause" : @"Play";
    [self.playButton setTitle:playLabelText forState:UIControlStateNormal];

    // Tiem label
    self.timeLabel.text = [NSString stringWithFormat:@"%@ / %@",
                           [self secondToTime:self.player.amountPlayed],
                           [self secondToTime:self.player.trackTime]];

    // Time slider
    self.timeSlider.value = self.player.amountPlayed;
    self.timeSlider.maximumValue = self.player.trackTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshUI];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self refreshUI];

    self.refreshTimer = [NSTimer scheduledTimerWithTimeInterval:0.25
                                                         target:self
                                                       selector:@selector(refreshUI)
                                                       userInfo:nil
                                                        repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.refreshTimer invalidate];
    self.refreshTimer = nil;
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - Interface

- (IBAction)playClicked:(id)sender {
    if (self.player.currentState == ORGMEngineStatePlaying) {
        [self.player pause];
    } else if (self.player.currentState == ORGMEngineStatePaused) {
        [self.player resume];
    } else {
        [self.player playUrl:Song.global.songURL];
    }
}

- (IBAction)slideTo:(UISlider *)sender {
    [self.player seekToTime:sender.value];
}

#pragma mark - ORGMEngine delegate

- (NSURL *)engineExpectsNextUrl:(ORGMEngine *)engine
{
    NSLog(@"%s", __func__);
 /*
    NSURL* url = Song.global.songURL;
    return url;
 */
    return nil;
}

- (void)engine:(ORGMEngine *)engine didChangeState:(ORGMEngineState)state
{
   NSString *stateString = @"Unknown";
    switch (state) {
        case ORGMEngineStatePlaying:
            stateString = @"Playing";
            break;
        case ORGMEngineStateStopped:
            stateString = @"Stopped";
            break;
        case ORGMEngineStatePaused:
            stateString = @"Paused";
            break;
        case ORGMEngineStateError:
            stateString = [NSString stringWithFormat:@"Error: %@", [self.player.currentError localizedDescription]];
            break;
        default:
            break;
    }
    [self refreshUI];
    NSLog(@"%s %@ %@", __func__, stateString, Song.global.pathName);
}

@end
