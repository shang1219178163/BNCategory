//
//  UITableViewHeaderFooterView+AddView.h
//  
//
//  Created by BIN on 2018/8/24.
//  Copyright © 2018年 SHANG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NSObject+Helper.h"
#import "UIView+Helper.h"

NS_ASSUME_NONNULL_BEGIN

@interface UITableViewHeaderFooterView (AddView)

@property (nonatomic, strong) UIImageView * viewIndicator;
@property (nonatomic, strong) UIImageView * imgViewLeft;
@property (nonatomic, strong) UIImageView * imgViewRight;

@property (nonatomic, strong) UILabel * labelLeft;
@property (nonatomic, strong) UILabel * labelLeftMark;
@property (nonatomic, strong) UILabel * labelLeftSub;
@property (nonatomic, strong) UILabel * labelLeftSubMark;

@property (nonatomic, strong) UIButton * btn;

@property (nonatomic, assign) BOOL isOpen;
@property (nonatomic, assign) BOOL isCanOPen;//默认为NO

@property (nonatomic, copy) void (^blockView)(UITableViewHeaderFooterView *foldView,NSInteger index);

+(instancetype)viewWithTableView:(UITableView *)tableView identifier:(NSString *)identifier;
+(instancetype)viewWithTableView:(UITableView *)tableView;

@end

//折叠数据模型
@interface BNFoldSectionModel : NSObject

@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * titleSub;

@property (nonatomic, strong) NSMutableArray * dataList;

@property (nonatomic, strong) id image;
@property (nonatomic, assign) BOOL isOpen;

@end

NS_ASSUME_NONNULL_END
