//
//  YXDCustomIndexView.m
//  CustomIndexViewDemo
//
//  Created by dd on 15/1/8.
//  Copyright (c) 2015年 YangXudong. All rights reserved.
//

#import "YXDCustomIndexView.h"

#define YXDTitleTextColorDefault            [UIColor darkGrayColor]

#define YXDTitleLableWidthHeightRate        0.7


@interface YXDCustomIndexView ()

@property (nonatomic, assign) CGPoint selfCenter;

@property (nonatomic, strong) NSMutableArray *arr_titleLable;

@property (nonatomic, assign) int currentSelectedIndex;

@end


@implementation YXDCustomIndexView

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self action_receiveTouchEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [self action_receiveTouchEvent:event];
}

- (void) action_receiveTouchEvent:(UIEvent *)event {
    CGPoint point = [[[event allTouches].allObjects firstObject] locationInView:self];
    
    for (int i = 0 ; i < _arr_titleLable.count ; i++) {
        
        UILabel *titleLable = _arr_titleLable[i];
        
        if (CGRectContainsPoint(titleLable.frame, point)) {
            [self action_touchIndex:i];
            return;
        }
    }
}

- (void) action_touchIndex:(int)index {
    
    if (index == _currentSelectedIndex) {
        return;
    } else {
        _currentSelectedIndex = index;
        
        if ([self.delegate respondsToSelector:@selector(customIndexView:selectedSectionIndex:)]) {
            [self.delegate customIndexView:self selectedSectionIndex:index];
        }
    }
}

#pragma mark -

- (void) action_createSectionTitles {
    
    //重新设置self frame
    self.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.width * (_sectionTitleArray.count * YXDTitleLableWidthHeightRate + 1));
    self.center = self.selfCenter;
    
    self.arr_titleLable = [NSMutableArray array];
    
    for (int i = 0; i < _sectionTitleArray.count; i++) {
        
        UILabel *lable = [self action_createTitleLableWithTitle:_sectionTitleArray[i]
                                                          frame:CGRectMake(0,
                                                                           self.frame.size.width*YXDTitleLableWidthHeightRate*i + self.frame.size.width/2,
                                                                           self.frame.size.width,
                                                                           self.frame.size.width*YXDTitleLableWidthHeightRate)];
        
        [self addSubview:lable];
        [_arr_titleLable addObject:lable];
    }
}

- (UILabel *) action_createTitleLableWithTitle:(NSString *)title frame:(CGRect)frame {
    
    UILabel *lable = [[UILabel alloc] initWithFrame:frame];
    
    lable.textAlignment = NSTextAlignmentCenter;
    lable.textColor = YXDTitleTextColorDefault;
    lable.text = title;
    lable.backgroundColor = [UIColor clearColor];
    lable.adjustsFontSizeToFitWidth = YES;

    return lable;
}

- (void) action_clearView {
    for (UIView *view in _arr_titleLable) {
        [view removeFromSuperview];
    }
    [_arr_titleLable removeAllObjects];
    self.arr_titleLable = nil;
}

-(void)reloadSection {
    [self action_clearView];
    [self action_createSectionTitles];
}

-(void)setSectionTitleArray:(NSArray *)sectionTitleArray {
    _sectionTitleArray = sectionTitleArray;
    [self reloadSection];
}

+(YXDCustomIndexView *)customIndexViewWithWidth:(float)width
                                         center:(CGPoint)center
                              sectionTitleArray:(NSArray *)sectionTitleArray
                                       delegate:(id)delegate
                                      superView:(UIView *)superView {
    
    float height = width * (sectionTitleArray.count * YXDTitleLableWidthHeightRate + 1);
    
    YXDCustomIndexView *customIndexView = [[YXDCustomIndexView alloc] initWithFrame:CGRectMake(0, 0, width, height)];
    
    customIndexView.center = center;
    
    customIndexView.selfCenter = center;
    
    customIndexView.delegate = delegate;
    
    customIndexView.clipsToBounds = YES;
    
    customIndexView.sectionTitleArray = sectionTitleArray;
    
    customIndexView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
    
    customIndexView.layer.cornerRadius = width/2;
    
    customIndexView.currentSelectedIndex = -1;
    
    [superView addSubview:customIndexView];
    
    [superView bringSubviewToFront:customIndexView];
    
    return customIndexView;
}

@end
