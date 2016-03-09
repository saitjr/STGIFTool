//
//  STGIFInfo.m
//  STGIFTool
//
//  Created by TangJR on 3/2/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

#import "STGIFInfo.h"
#import <ImageIO/ImageIO.h>

@interface STGIFInfo ()

@property (copy, nonatomic) NSString *gifPath;

@end

@implementation STGIFInfo

- (instancetype)initWithGifPath:(NSString *)gifPath {
    self = [super init];
    if (self) {
        self.gifPath = gifPath;
        [self setupData];
    }
    return self;
}

- (void)setupData {
    NSURL *url = [NSURL fileURLWithPath:self.gifPath];
    
    CGImageSourceRef gifSource = CGImageSourceCreateWithURL((__bridge CFURLRef)url, NULL);
    
    //获取gif的帧数
    size_t frameCount = CGImageSourceGetCount(gifSource);
    _frameCount = frameCount;
    
    //获取GfiImage的基本数据
    NSDictionary *gifProperties = (__bridge NSDictionary *) CGImageSourceCopyProperties(gifSource, NULL);
    //由GfiImage的基本数据获取gif数据
    NSDictionary *gifDictionary =[gifProperties objectForKey:(NSString*)kCGImagePropertyGIFDictionary];
    //获取gif的播放次数 0-无限播放
    _loopCount = [[gifDictionary objectForKey:(NSString*)kCGImagePropertyGIFLoopCount] integerValue];
    CFRelease((__bridge CFTypeRef)(gifProperties));
    
    NSMutableArray *frameImages = [NSMutableArray new];
    NSMutableArray *delayTimes = [NSMutableArray new];
    
    for (size_t i = 0; i < frameCount; ++i) {
        //得到每一帧的CGImage
        CGImageRef frame = CGImageSourceCreateImageAtIndex(gifSource, i, NULL);
        [frameImages addObject:[UIImage imageWithCGImage:frame]];
        CGImageRelease(frame);
        
        //获取每一帧的图片信息
        NSDictionary *frameDict = (__bridge NSDictionary*)CGImageSourceCopyPropertiesAtIndex(gifSource, i, NULL);
        
        //获取Gif图片尺寸
        _width = [[frameDict valueForKey:(NSString*)kCGImagePropertyPixelWidth] floatValue];
        _height = [[frameDict valueForKey:(NSString*)kCGImagePropertyPixelHeight] floatValue];
        
        //由每一帧的图片信息获取gif信息
        NSDictionary *gifDict = [frameDict valueForKey:(NSString*)kCGImagePropertyGIFDictionary];
        //取出每一帧的delaytime
        [delayTimes addObject:[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime]];
        
        _totalTime = _totalTime + [[gifDict valueForKey:(NSString*)kCGImagePropertyGIFDelayTime] floatValue];
        
        CFRelease((__bridge CFTypeRef)(frameDict));
    }
    _images = [frameImages copy];
    _delayTimes = [delayTimes copy];
    CFRelease(gifSource);
}

@end