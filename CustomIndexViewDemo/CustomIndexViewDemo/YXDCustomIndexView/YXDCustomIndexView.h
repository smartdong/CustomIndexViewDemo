//
//  YXDCustomIndexView.h
//  CustomIndexViewDemo
//
//  Created by dd on 15/1/8.
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXDCustomIndexView;

@protocol YXDCustomIndexViewDelegate <NSObject>

/**
 *  选择了某个索引
 */
- (void) customIndexView:(YXDCustomIndexView *)customView selectedSectionIndex:(int)index;

@end


@interface YXDCustomIndexView : UIView

@property (nonatomic, weak) id<YXDCustomIndexViewDelegate> delegate;

@property (nonatomic, strong) NSArray *sectionTitleArray;

+ (YXDCustomIndexView *) customIndexViewWithWidth:(float)width
                                           center:(CGPoint)center
                                sectionTitleArray:(NSArray *)sectionTitleArray
                                         delegate:(id)delegate
                                        superView:(UIView *)superView;

@end
