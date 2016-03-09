//
//  ViewController.m
//  STGIFTool
//
//  Created by TangJR on 3/2/16.
//  Copyright © 2016 tangjr. All rights reserved.
//

#import "ViewController.h"
#import "STGIFInfo.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *filePath = @"/Users/tangjr/Documents/iOS/BWSoft/Fan/设计图/gif/猫.gif";
    STGIFInfo *info = [[STGIFInfo alloc] initWithGifPath:filePath];
    NSLog(@"%@", info.images);
}

@end