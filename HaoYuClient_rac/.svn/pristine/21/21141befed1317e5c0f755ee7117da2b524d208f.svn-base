//
//  HYProjectThemeSizeFactory.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYProjectThemeSizeFactory.h"

@implementation HYProjectThemeSizeFactory

/**
 屏幕尺寸适配
 
 @param adjustPercentFloat      需要适配尺寸
 @return                        按百分比适配后尺寸
 */
+ (CGFloat)projectSizeFatoryAdjustPercentFloat:(CGFloat)adjustPercentFloat
{
    if (SCREEN_SCALE == 1) {
        
        /**
         *  小屏幕
         */
        return (adjustPercentFloat * SCREEN_WIDTH / 375);
        
    }else if (SCREEN_SCALE == 2){
        
        /**
         *  iphone6
         */
        if (iPhone5SE) {
            
            return (adjustPercentFloat * SCREEN_WIDTH / 375);
        }else{
            return (adjustPercentFloat * 375 / 375);
        }
        
    }else if (SCREEN_SCALE == 3){
        
        /**
         *  iphone6Plus
         */
        return (adjustPercentFloat * SCREEN_WIDTH / 375);
        
    }else{
        
        return (adjustPercentFloat * SCREEN_WIDTH / 375);
    }
}
@end
