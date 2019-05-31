//
//  LWDelegateHandler.h
//  HaoYuClient
//
//  Created by 刘文强 on 2019/4/11.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@interface LWTFHandler : NSObject<UITextFieldDelegate>

/** 代理方法的回调接口 (使用blocksKit框架，这里不做处理了) */
@property (nonatomic, copy) void(^DidEndEditingBlock)(id);

/** tf长度的限制 缓存 默认 10 */
@property (nonatomic, assign) NSInteger tfLenghtCacheLimit;
/** <key:btn, value:tfs> btn管理tfs数组的缓存 默认 10 */
@property (nonatomic, assign) NSInteger relationInforCacheLimit;
/** 控制器栈的限制 最大默认 5 */
@property (nonatomic, assign) NSInteger viewControllerStackLimit;


+ (instancetype)share;

/**
 处理TextField长度限制方法
 
 @param tf 代理对象/对象数组
 @param maxCount    限制长度/长度数组（数组长度小于对象数组长度，默认是不做限制）
 */
+ (void)handleTextFieldLenghtLimitWithTF:(id)tf maxCount:(id)maxCount;

/**
 把textfield集合 输入的内容关联 btn 状态 (注意:尽量保证在该控件及supView已经添加到控制器上，虽然内容也会处理)
 
 @param tfs textfield的集合
 @param bt 需要关联的btn
 */
+ (void)handleTextFieldRelationButtonStateWithTF:(NSArray *)tfs BT:(UIButton *)bt;

/**
 根据控制器，清除该控制器下handler的关联缓存信息(当改控制器销毁的时候调用)
 */
+ (void)removeHandlerCacheWithViewController:(UIViewController *)vc;

/**
 清除 handler的所有按钮状态的关联缓存信息
 */
+ (void)removeAllHandlerCache;

@end

NS_ASSUME_NONNULL_END
