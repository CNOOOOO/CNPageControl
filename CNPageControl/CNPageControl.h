//
//  CNPageControl.h
//  DisplayTheHandRing
//
//  Created by Mac2 on 2018/9/21.
//  Copyright © 2018年 Mac2. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CNPageControlStyle) {
    CNPageControlStyleDefalut = 0,          ///默认圆形
    CNPageControlStyleSquare,               ///正方形
    CNPageControlStyleRoundedRectangle,     ///圆角矩形
    CNPageControlStyleImage                 ///图片
};

typedef NS_ENUM(NSInteger, PageControlAlign) {
    PageControlAlignCenter = 0,             ///默认居中
    PageControlAlignLeft,                   ///居左
    PageControlAlignRight                   ///居右
};

@interface CNPageControl : UIView

/** indicator的样式 */
@property (nonatomic, assign) CNPageControlStyle style;
/** indicator的位置，默认居中 */
@property (nonatomic, assign) PageControlAlign pageAlign;
/** 总页数，默认0 */
@property (nonatomic, assign) NSInteger numberOfPages;
/** 当前页，默认0 */
@property (nonatomic, assign) NSInteger currentPage;
/** 只有一页时，隐藏indicator，默认NO */
@property (nonatomic, assign) BOOL hidesForSinglePage;
/** indicator的默认颜色 */
@property (nullable, nonatomic,strong) UIColor *pageIndicatorTintColor;
/** 当前indicator的颜色 */
@property (nullable, nonatomic,strong) UIColor *currentPageIndicatorTintColor;
/** 自定义indicator的间隔 */
@property (nonatomic, assign) CGFloat indicatorSpace;
/** 居左、居右显示时距离两边的间距 */
@property (nonatomic, assign) CGFloat leftAndRightSpace;
/** 自定义indicator的尺寸 */
@property (nonatomic, assign) CGSize indicatorSize;
/** 当前indicator是否变大，默认不变大 */
@property (nonatomic, assign) BOOL isScalable;
/** 是否显示边框 */
@property (nonatomic, assign) BOOL isBorder;
/** 边框颜色 */
@property (nonatomic, strong) UIColor *borderColor;
/** 边框宽度 */
@property (nonatomic, assign) CGFloat borderWidth;

- (instancetype)initWithFrame:(CGRect)frame pageStyle:(CNPageControlStyle)style;
- (instancetype)initWithFrame:(CGRect)frame normalImageArray:(NSArray *)normalImages highlightImages:( NSArray * _Nullable )highlightImages;

@end
