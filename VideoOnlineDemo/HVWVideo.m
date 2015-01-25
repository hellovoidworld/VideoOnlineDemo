//
//  HVWVideo.m
//  VideoOnlineDemo
//
//  Created by hellovoidworld on 15/1/24.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWVideo.h"
#define ServerIP @"http://192.168.0.21:8080/MyTestServer"

@implementation HVWVideo

+ (instancetype) videoWithDict:(NSDictionary *) dict {
    HVWVideo *video = [[self alloc] init];
    video.name = dict[@"name"];
    video.image = dict[@"image"];
    video.length = dict[@"length"];
    video.video = dict[@"video"];
    
    return video;
}

@end
