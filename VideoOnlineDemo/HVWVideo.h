//
//  HVWVideo.h
//  VideoOnlineDemo
//
//  Created by hellovoidworld on 15/1/24.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HVWVideo : NSObject

@property(nonatomic, strong) NSString *name;
@property(nonatomic, strong) NSString *length;
@property(nonatomic, strong) NSString *image;
@property(nonatomic, strong) NSString *video;

+ (instancetype) videoWithDict:(NSDictionary *) dict;

@end
