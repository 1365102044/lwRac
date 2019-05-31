//
//  HYProjectThemeColorFactory.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYProjectThemeColorFactory.h"

@implementation HYProjectThemeColorFactory

+ (instancetype)projectThemeColorFatoryWithFilePath:(NSString *)filePath
{
NSData *colorData                                       = [NSData dataWithContentsOfFile:filePath];
NSError *error;
NSJSONSerialization *colorJSON                          = [NSJSONSerialization JSONObjectWithData:colorData
                                                                                          options:0
                                                                                            error:&error];
HYProjectThemeColorFactory *themeColorFatory             = [HYProjectThemeColorFactory modelWithJSON:colorJSON];
return themeColorFatory;
}

- (UIColor *)color_c0
{
    if (!_color_c0) {
        _color_c0 = [UIColor colorWithHexString:self.c0];
}
return _color_c0;
}
/**
 *  #FEFEFE
 */
- (UIColor *)color_c1
{
    if (!_color_c1) {
        _color_c1 = [UIColor colorWithHexString:self.c1];
    }
    return _color_c1;
}
/**
 #999999
 */
- (UIColor *)color_c2
{
    if (!_color_c2) {
        _color_c2 = [UIColor colorWithHexString:self.c2];
    }
    return _color_c2;
}
/**
 #e95514 主题色
 */
- (UIColor *)color_c3
{
    if (!_color_c3) {
        _color_c3 = [UIColor colorWithHexString:self.c3];
    }
    return _color_c3;
}
/**
 #333333
 */
- (UIColor *)color_c4
{
    if (!_color_c4) {
        _color_c4 = [UIColor colorWithHexString:self.c4];
    }
    return _color_c4;
}
/**
 #FF9900
 */
- (UIColor *)color_c5
{
    if (!_color_c5) {
        _color_c5 = [UIColor colorWithHexString:self.c5];
    }
    return _color_c5;
}


/**
 #BD081C
 */
- (UIColor *)color_c26
{
    if (!_color_c26) {
        _color_c26 = [UIColor colorWithHexString:self.c26];
    }
    return _color_c26;
}
/**
 #D2D2D2
 */
- (UIColor *)color_c28
{
    if (!_color_c28) {
        _color_c28 = [UIColor colorWithHexString:self.c28];
    }
    return _color_c28;
}
/**
 #C27880
 */
- (UIColor *)color_c31
{
    if (!_color_c31) {
        _color_c31 = [UIColor colorWithHexString:self.c31];
    }
    return _color_c31;
}
/**
 #E1E1E1
 */
- (UIColor *)color_c6
{
    if (!_color_c6) {
        _color_c6 = [UIColor colorWithHexString:self.c6];
    }
    return _color_c6;
}
/**
 #FF9800
 */
- (UIColor *)color_c32
{
    if (!_color_c32) {
        _color_c32 = [UIColor colorWithHexString:self.c32];
    }
    return _color_c32;
}
/**
 #FFCD84
 */
- (UIColor *)color_c33
{
    if (!_color_c33) {
        _color_c33 = [UIColor colorWithHexString:self.c33];
    }
    return _color_c33;
}
/**
 #BBBBBB
 */
- (UIColor *)color_c34
{
    if (!_color_c34) {
        _color_c34 = [UIColor colorWithHexString:self.c34];
    }
    return _color_c34;
}
/**
 #E0E0E0
 */
- (UIColor *)color_c35
{
    if (!_color_c35) {
        _color_c35 = [UIColor colorWithHexString:self.c35];
    }
    return _color_c35;
}
/**
 #39A1AC
 */
- (UIColor *)color_c36
{
    if (!_color_c36) {
        _color_c36 = [UIColor colorWithHexString:self.c36];
    }
    return _color_c36;
}
@end
