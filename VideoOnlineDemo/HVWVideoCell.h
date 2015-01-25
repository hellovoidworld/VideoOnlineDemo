//
//  HVWVideoCell.h
//  VideoOnlineDemo
//
//  Created by hellovoidworld on 15/1/25.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HVWVideo.h"

@interface HVWVideoCell : UITableViewCell

@property(nonatomic, strong) HVWVideo *video;

+ (instancetype) cellWithTableView:(UITableView *) tableView;

@end
