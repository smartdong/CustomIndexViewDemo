//
//  ViewController.m
//  CustomIndexViewDemo
//
//  Created by dd on 15/1/8.
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#import "ViewController.h"
#import "YXDCustomIndexView.h"


@interface ViewController ()<YXDCustomIndexViewDelegate>

@property (nonatomic, strong) YXDCustomIndexView *customIndexView;

@property (weak, nonatomic) IBOutlet UILabel *lbl_lable;

@property (nonatomic, strong) NSArray *sectionTitleArray;

@end

@implementation ViewController

- (IBAction)action_changeIndex {
    self.sectionTitleArray = [self getSectionTitles];
    _customIndexView.sectionTitleArray = self.sectionTitleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self action_changeIndex];
    
    self.customIndexView = [YXDCustomIndexView customIndexViewWithWidth:30
                                                                 center:CGPointMake(100, [UIScreen mainScreen].bounds.size.height/2)
                                                      sectionTitleArray:self.sectionTitleArray
                                                               delegate:self
                                                              superView:self.view];
    
}

-(void)customIndexView:(YXDCustomIndexView *)customView selectedSectionIndex:(int)index {
    _lbl_lable.text = _sectionTitleArray[index];
}


//

- (NSArray *) getSectionTitles {
    
    int index = arc4random() % 10 + 5;
    
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i=0; i < index; i++) {
        [arr addObject:[NSString stringWithFormat:@"%d",i]];
    }

    return arr;
}


@end
