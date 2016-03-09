//
//  STGIFInfo.h
//  STGIFTool
//
//  Created by TangJR on 3/2/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STGIFInfo : NSObject

@property (copy, nonatomic, readonly) NSArray *images; ///< 图片数组
@property (copy, nonatomic, readonly) NSArray *delayTimes; ///< 每帧图的延迟
@property (assign, nonatomic, readonly) size_t frameCount; ///< 帧数
@property (assign, nonatomic, readonly) NSInteger loopCount; ///< 循环次数
@property (assign, nonatomic, readonly) NSTimeInterval totalTime; ///< 播放总时长
@property (assign, nonatomic, readonly) CGFloat width; ///< 图片宽度
@property (assign, nonatomic, readonly) CGFloat height; ///< 图片高度

- (instancetype)initWithGifPath:(NSString *)gifPath;

@end