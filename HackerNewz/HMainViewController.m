//
//  HMainViewController.m
//  HackerNewz
//
//  Created by Skye on 6/24/15.
//  Copyright (c) 2015 Skye Freeman. All rights reserved.
//

#import "HMainViewController.h"
#import "HHackerNewsHelper.h"

@interface HMainViewController ()
@end

@implementation HMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [HHackerNewsHelper topStories:^(id stories, NSError *error) {
        if (!error) {
            NSLog(@"%@",stories);
            [HHackerNewsHelper itemWithID:[stories objectAtIndex:0] completion:^(id itemObject, NSError *error) {
                if (!error) {
                    NSLog(@"%@",itemObject);
                } else {
                    NSLog(@"%@",error);
                }
            }];
        } else {
            NSLog(@"%@",error);
        }
    }];
}

@end
