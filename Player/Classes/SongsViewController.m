//
//  SongsViewController.m
//  Player
//
//  Created by Horace Ho on 2015/02/24.
//  Copyright (c) 2015 Horace Ho. All rights reserved.
//

#import "MHWDirectoryWatcher.h"
#import "FCFileManager.h"
#import "Song.h"
#import "PlayViewController.h"
#import "SongsViewController.h"

@interface SongsViewController ()

@property (strong, nonatomic) MHWDirectoryWatcher *directoryWatcher;
@property (strong, nonatomic) NSMutableArray *songs;
@property (strong, nonatomic) Song *song;

@end

@implementation SongsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.directoryWatcher startWatching];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.directoryWatcher stopWatching];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data

- (MHWDirectoryWatcher *)directoryWatcher {
    if (_directoryWatcher == nil) {
        _directoryWatcher = [MHWDirectoryWatcher directoryWatcherAtPath:[FCFileManager pathForDocumentsDirectory]
                                                               callback:^{
                                                                   [self refreshUI];
                                                               }];
    }
    return _directoryWatcher;
}

- (NSString *)folder{
    if (_folder == nil) {
        _folder = [FCFileManager pathForDocumentsDirectory];
    }
    return _folder;
}

- (NSMutableArray *)songs {
    if (_songs == nil) {
        NSArray *files = [FCFileManager listFilesInDirectoryAtPath:self.folder];
        _songs = [[NSMutableArray alloc] initWithArray:files];
    }
    return _songs;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sections = 1;
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = self.songs.count;
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"SongCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    NSString *filename = (self.songs)[indexPath.row];
    Song *song = [[Song alloc] initWithPathname:filename];
    cell.textLabel.text = song.songName;
    cell.detailTextLabel.text = song.fileName;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *filename = (self.songs)[indexPath.row];
    Song.global.pathName = filename;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Interface

- (void)refreshUI {
    NSLog(@"%s", __func__);
    _songs = nil;
    [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // UINavigationController *navigationController = [segue destinationViewController];
 // PlayViewController *playViewController = [[navigationController viewControllers] firstObject];
}

@end
