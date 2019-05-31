//
//  LWAddPhotoManager.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/5/21.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HYAddPhotoView.h"

NS_ASSUME_NONNULL_BEGIN

@interface LWAddPhotoManager : NSObject<addPhotoDelegate>

- (void)setAddPicManager:(HYAddPhotoView *)addPhotoView;
/** imageUrs */
@property (nonatomic, strong) NSArray * selectImages;
@property (nonatomic, strong) UIViewController * curVC;
//key: image  value: url
@property (nonatomic, strong) NSMutableDictionary * selImageUrlDict;
@end

NS_ASSUME_NONNULL_END
