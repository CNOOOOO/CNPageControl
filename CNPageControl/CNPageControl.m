//
//  CNPageControl.m
//  DisplayTheHandRing
//
//  Created by Mac2 on 2018/9/21.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import "CNPageControl.h"

@interface CNPageControl ()

@property (nonatomic, strong) NSMutableArray *normalImages;
@property (nonatomic, strong) NSMutableArray *highlightImages;

@end

@implementation CNPageControl

- (NSMutableArray *)normalImages {
    if (!_normalImages) {
        _normalImages = [NSMutableArray array];
    }
    return _normalImages;
}

- (NSMutableArray *)highlightImages {
    if (!_highlightImages) {
        _highlightImages = [NSMutableArray array];
    }
    return _highlightImages;
}

- (instancetype)initWithFrame:(CGRect)frame pageStyle:(CNPageControlStyle)style {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        _style = style;
        _pageAlign = PageControlAlignCenter;
        _numberOfPages = 0;
        _currentPage = 0;
        _hidesForSinglePage = NO;
        _pageIndicatorTintColor = [UIColor lightGrayColor];
        _currentPageIndicatorTintColor = [UIColor whiteColor];
        _indicatorSize = CGSizeMake(10, 10);
        _indicatorSpace = 10;
        _leftAndRightSpace = 15;
        _isBorder = NO;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame normalImageArray:(NSArray *)normalImages highlightImages:( NSArray * _Nullable )highlightImages {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.normalImages = [normalImages mutableCopy];
        self.highlightImages = [highlightImages mutableCopy];
        _style = CNPageControlStyleImage;
        _pageAlign = PageControlAlignCenter;
        _numberOfPages = normalImages.count;
        _currentPage = 0;
        _hidesForSinglePage = NO;
        _pageIndicatorTintColor = [UIColor lightGrayColor];
        _currentPageIndicatorTintColor = [UIColor whiteColor];
        _indicatorSize = CGSizeMake(10, 10);
        _indicatorSpace = 10;
        _leftAndRightSpace = 15;
        _isBorder = NO;
        [self setUpPageControl];
    }
    return self;
}

- (void)setUpPageControl {
    //移除所有子视图
    [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    if (_numberOfPages == 0) return;
    if (_hidesForSinglePage) {//单点隐藏
        if (_numberOfPages == 1) {
            return;
        }else {
            [self addIndicators];
        }
    }else {
        [self addIndicators];
    }
}

- (void)addIndicators {
    for (int i=0; i < _numberOfPages; i++) {
        UIImageView *indicator = [[UIImageView alloc] init];
        indicator.backgroundColor = _pageIndicatorTintColor;
        if (_isBorder) {
            indicator.layer.borderColor = _borderColor.CGColor;
            indicator.layer.borderWidth = _borderWidth;
        }
        [self addSubview:indicator];
        switch (_style) {
            case CNPageControlStyleSquare:
                [self layoutIndicator:indicator index:i];
                break;
            case CNPageControlStyleRoundedRectangle:
                indicator.layer.masksToBounds = YES;
                indicator.layer.cornerRadius = _indicatorSize.height * 0.5;
                [self layoutIndicator:indicator index:i];
                break;
            case CNPageControlStyleImage:
                indicator.contentMode = UIViewContentModeScaleAspectFill;
                indicator.clipsToBounds = YES;
                indicator.backgroundColor = [UIColor clearColor];
                indicator.layer.masksToBounds = YES;
                indicator.layer.cornerRadius = _indicatorSize.width * 0.5;
                indicator.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.normalImages[i]]];
                [self layoutIndicator:indicator index:i];
                break;
            default:
                indicator.layer.masksToBounds = YES;
                indicator.layer.cornerRadius = _indicatorSize.width * 0.5;
                [self layoutIndicator:indicator index:i];
                break;
        }
        //设置被选中的颜色和被选中的点
        if (_isScalable) {
            if (i == _currentPage) {
                if (_style == CNPageControlStyleImage) {
                    if (self.highlightImages.count) {
                        indicator.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.highlightImages[i]]];
                    }
                }else {
                    indicator.backgroundColor = _currentPageIndicatorTintColor;
                }
                [UIView animateWithDuration:0.3 animations:^{
                   indicator.transform = CGAffineTransformMakeScale(1.3, 1.3);
                }];
            }
        }else {
            if (i == _currentPage) {
                if (_style == CNPageControlStyleImage) {
                    if (self.highlightImages.count) {
                        indicator.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.highlightImages[i]]];
                    }
                }else {
                    indicator.backgroundColor = _currentPageIndicatorTintColor;
                }
            }
        }
    }
}

- (void)layoutIndicator:(UIImageView *)indicator index:(int)i {
    switch (_pageAlign) {
        case PageControlAlignLeft:
        {
            indicator.frame = CGRectMake(_leftAndRightSpace + (i * (_indicatorSize.width + _indicatorSpace)), self.bounds.size.height * 0.5 - _indicatorSize.height * 0.5, _indicatorSize.width, _indicatorSize.height);
        }
            break;
        case PageControlAlignRight:
        {
            indicator.frame = CGRectMake(self.bounds.size.width - _leftAndRightSpace - (_numberOfPages - i) * _indicatorSize.width - (_numberOfPages - i - 1) * _indicatorSpace, self.bounds.size.height * 0.5 - _indicatorSize.height * 0.5, _indicatorSize.width, _indicatorSize.height);
        }
            break;
        default:
        {
            int a = (int)_numberOfPages / 2;
            if (_numberOfPages % 2 == 0) {
                indicator.frame = CGRectMake(self.bounds.size.width * 0.5 - ((a - i) * _indicatorSize.width + (a - i - 0.5) * _indicatorSpace), self.bounds.size.height * 0.5 - _indicatorSize.height * 0.5, _indicatorSize.width, _indicatorSize.height);
            }else {
                indicator.frame = CGRectMake(self.bounds.size.width * 0.5 - ((a - i + 0.5) * _indicatorSize.width + (a - i) * _indicatorSpace), self.bounds.size.height * 0.5 - _indicatorSize.height * 0.5, _indicatorSize.width, _indicatorSize.height);
            }
        }
            break;
    }
}

- (void)setStyle:(CNPageControlStyle)style {
    _style = style;
    [self setUpPageControl];
}

- (void)setPageAlign:(PageControlAlign)pageAlign {
    _pageAlign = pageAlign;
    [self setUpPageControl];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages {
    _numberOfPages = numberOfPages;
    [self setUpPageControl];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    _currentPage = currentPage;    
    for (int i=0; i < self.subviews.count; i++) {
        UIImageView *imageView = self.subviews[i];
        //设置被选中的颜色和被选中的点
        if (_isScalable) {
            if (i == _currentPage) {
                [UIView animateWithDuration:0.3 animations:^{
                    imageView.transform = CGAffineTransformMakeScale(1.3, 1.3);
                }];
                if (_style == CNPageControlStyleImage) {
                    if (self.highlightImages.count) {
                        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.highlightImages[i]]];
                    }else {
                        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.normalImages[i]]];
                    }
                }else {
                    imageView.backgroundColor = _currentPageIndicatorTintColor;
                }
            }else {
                imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
                if (_style == CNPageControlStyleImage) {
                    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.normalImages[i]]];
                }else {
                    imageView.backgroundColor = _pageIndicatorTintColor;
                }
            }
        }else {
            if (i == _currentPage) {
                if (_style == CNPageControlStyleImage) {
                    if (self.highlightImages.count) {
                        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.highlightImages[i]]];
                    }else {
                        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.normalImages[i]]];
                    }
                }else {
                    imageView.backgroundColor = _currentPageIndicatorTintColor;
                }
            }else {
                if (_style == CNPageControlStyleImage) {
                    imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.normalImages[i]]];
                }else {
                    imageView.backgroundColor = _pageIndicatorTintColor;
                }
            }
        }
    }
}

- (void)setHidesForSinglePage:(BOOL)hidesForSinglePage {
    _hidesForSinglePage = hidesForSinglePage;
    [self setUpPageControl];
}

- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    _pageIndicatorTintColor = pageIndicatorTintColor;
    if (_style != CNPageControlStyleImage) {
        [self setUpPageControl];
    }
}

- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    if (_style != CNPageControlStyleImage) {
        [self setUpPageControl];
    }
}

- (void)setIndicatorSize:(CGSize)indicatorSize {
    _indicatorSize = indicatorSize;
    [self setUpPageControl];
}

- (void)setIndicatorSpace:(CGFloat)indicatorSpace {
    _indicatorSpace = indicatorSpace;
    [self setUpPageControl];
}

- (void)setLeftAndRightSpace:(CGFloat)leftAndRightSpace {
    _leftAndRightSpace = leftAndRightSpace;
    [self setUpPageControl];
}

- (void)setIsScalable:(BOOL)isScalable {
    _isScalable = isScalable;
    [self setUpPageControl];
}

- (void)setIsBorder:(BOOL)isBorder {
    _isBorder = isBorder;
    [self setUpPageControl];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    [self setUpPageControl];
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    _borderWidth = borderWidth;
    [self setUpPageControl];
}

@end
