//
//  HVWVideoCell.m
//  VideoOnlineDemo
//
//  Created by hellovoidworld on 15/1/25.
//  Copyright (c) 2015年 hellovoidworld. All rights reserved.
//

#import "HVWVideoCell.h"
#import "UIImageView+WebCache.h"

#define ServerIP @"http://192.168.0.21:8080/MyTestServer"

@interface HVWVideoCell()

/** 分割线 */
@property(nonatomic, strong) UIView *separatorLine;

@end

@implementation HVWVideoCell

+ (instancetype) cellWithTableView:(UITableView *) tableView {
    static NSString *ID = @"VideoCell";
    
    HVWVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (nil == cell) {
        cell = [[HVWVideoCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 重写样式
        // 自定义分割写
        UIView *separatorLine = [[UIView alloc] init];
        separatorLine.backgroundColor = [UIColor lightGrayColor];
        separatorLine.alpha = 0.3;
        [self.contentView addSubview:separatorLine];
        
        self.separatorLine = separatorLine;
    }
    
    return self;
}

/** 重写内部子控件的位置尺寸 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置图片
    CGFloat imageWidth = 100;
    CGFloat imageHeight = 56;
    CGFloat imageX = 10;
    CGFloat imageY = (self.frame.size.height - imageHeight) / 2;
    CGRect imageFrame = CGRectMake(imageX, imageY, imageWidth, imageHeight);
    self.imageView.frame = imageFrame;
    
    // 设置标题
    CGRect textFrame = self.textLabel.frame;
    textFrame.origin.x = imageX + imageWidth + 10;
    self.textLabel.frame = textFrame;
    
    // 设置副标题
    CGRect detailFrame = self.detailTextLabel.frame;
    detailFrame.origin.x = self.textLabel.frame.origin.x;
    self.detailTextLabel.frame = detailFrame;
    
    // 设置分割线
    CGFloat separatorLineY = self.frame.size.height - 1;
    self.separatorLine.frame = CGRectMake(0, separatorLineY, self.frame.size.width, 1);
}

/** 设置数据 */
- (void)setVideo:(HVWVideo *)video {
    _video = video;
    
    // 设置标题 & 副标题
    self.textLabel.text = video.name;
    self.detailTextLabel.text = video.length;
    
    // 下载图片
    NSString *imageUrlStr = [NSString stringWithFormat:@"%@/%@", ServerIP, video.image];
    NSURL *imageUrl = [NSURL URLWithString:imageUrlStr];
    [self.imageView setImageWithURL:imageUrl placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

@end
