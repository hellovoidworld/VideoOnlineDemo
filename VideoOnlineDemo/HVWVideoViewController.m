//
//  HVWVideoViewController.m
//  VideoOnlineDemo
//
//  Created by hellovoidworld on 15/1/25.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWVideoViewController.h"
#import "HVWVideo.h"
#import <MediaPlayer/MediaPlayer.h>
#import "HVWVideoCell.h"
#import "HVWMoviePlayerViewController.h"

#define ServerIP @"http://192.168.0.21:8080/MyTestServer"

@interface HVWVideoViewController () <UITableViewDataSource, UITableViewDelegate, NSURLConnectionDataDelegate>

/** 接收到的二进制数据 */
@property(nonatomic, strong) NSMutableData *data;

/** 所有的录像模型数据 */
@property(nonatomic, strong) NSArray *videos;

@end

@implementation HVWVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置代理
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    // 消除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // 读取服务器数据
    [self acceptDataFromServer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/** 读取服务器数据 */
- (void) acceptDataFromServer {
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/video", ServerIP]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLConnection *connection = [NSURLConnection connectionWithRequest:request delegate:self];
    [connection start];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.videos.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HVWVideoCell *cell = [HVWVideoCell cellWithTableView:tableView];
    
    cell.video = self.videos[indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 加载视频
    HVWVideo *video = self.videos[indexPath.row];
    NSString *videoUrlStr = [NSString stringWithFormat:@"%@/%@", ServerIP, video.video];
    NSURL *videoUrl = [NSURL URLWithString:videoUrlStr];
    
    NSLog(@"%@", videoUrlStr);
    
    // 使用MediaPlayer框架播放视频
    HVWMoviePlayerViewController *mvController = [[HVWMoviePlayerViewController alloc] initWithContentURL:videoUrl];
    [self presentMoviePlayerViewControllerAnimated:mvController];
}


#pragma mark - NSURLConnectionDataDelegate 代理方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"开始接收数据");
    self.data = [NSMutableData data];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    NSLog(@"接收数据中...");
    [self.data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"接收数据完毕");
    
    if (self.data) {
        // 加载视频资料
        NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:self.data options:NSJSONReadingMutableLeaves error:nil];
        
        //        NSLog(@"%@", jsonDict);
        NSArray *jsonArray = jsonDict[@"videos"];
        //        NSLog(@"%@", jsonArray);
        
        NSMutableArray *videoArray = [NSMutableArray array];
        for (NSDictionary *dict in jsonArray) {
            NSLog(@"%@", dict);
            HVWVideo *video = [HVWVideo videoWithDict:dict];
            [videoArray addObject:video];
        }
        self.videos = videoArray;
        
        [self.tableView reloadData];
    }
    
}


@end
