//
//  LWDelegateHandler.m
//  HaoYuClient
//
//  Created by 刘文强 on 2019/4/11.
//  Copyright © 2019年 LWQ. All rights reserved.
//

#import "LWTFHandler.h"
#import "HYBaseTextFiled.h"
@interface LWTFHandler ()<NSCopying>

@property (nonatomic, strong) UIButton * relationTempBtn;
/** tf 和 长度的信息 */
@property (nonatomic, strong) NSCache<UITextField *, NSNumber *> * tfLengthInforCache;
/** 关联按钮状态 的信息 缓存 <cache,>（解决 push pop问题） */
@property (nonatomic, strong) NSCache<UIButton *, NSArray *> * relationInforCache;
/** 当前vc 关联 btn */
@property (nonatomic, strong) NSCache<NSString *, NSArray<UIButton *> *> * curVcRelationBtnCache;

@end

@implementation LWTFHandler

+ (instancetype)share
{
    static LWTFHandler *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:nil] init];
        instance.tfLengthInforCache = [[NSCache alloc] init];
        instance.tfLengthInforCache.countLimit = 10;
        instance.relationInforCache = [[NSCache alloc] init];
        instance.relationInforCache.countLimit = 10;
        instance.curVcRelationBtnCache = [[NSCache alloc] init];
        instance.curVcRelationBtnCache.countLimit = 5;
    });
    return instance;
}
+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    return  [LWTFHandler share];
}
-(id)copyWithZone:(NSZone *)zone
{
    return [LWTFHandler share];
}
#pragma mark ********************* handler 方法 *********************

/**
 把textfield集合 输入的内容关联 btn 状态 (注意:尽量保证在该控件及supView已经添加到控制器上，虽然内容也会处理)
 
 @param tfs textfield的集合
 @param bt 需要关联的btn
 */
+ (void)handleTextFieldRelationButtonStateWithTF:(NSArray *)tfs BT:(UIButton *)bt
{
    if (tfs == nil || bt == nil) return;
    bt.enabled = NO;
    
    /** 保存数据到缓存 */
    UIViewController *cvc = [[LWTFHandler share] getCurrentViewControllerWithObjc:bt];
    NSMutableArray *oldbtns =  [[NSMutableArray alloc] initWithArray:[[LWTFHandler share].curVcRelationBtnCache objectForKey:NSStringFromClass(cvc.class)]];
    if(![oldbtns containsObject:bt]) [oldbtns addObject:bt];
    [[LWTFHandler share].curVcRelationBtnCache setObject:oldbtns forKey:NSStringFromClass(cvc.class)];
    [[LWTFHandler share].relationInforCache setObject:[[LWTFHandler share] getTF:tfs] forKey:bt];
    if (!cvc) {
        [LWTFHandler share].relationTempBtn = bt;
    }
    /** 第一次进入时，先检查输入框 是否有内容 */
    [[LWTFHandler share] handleRelationBtnsState:nil text:nil relationBtn:bt];
}

/**
 处理TextField长度限制方法
 
 @param tf 代理对象/对象数组
 @param maxCount    限制长度/长度数组（数组长度小于对象数组长度，默认是不做限制）
 */
+ (void)handleTextFieldLenghtLimitWithTF:(id)tf maxCount:(id)maxCount
{
    if (tf == nil) return;
    if (maxCount == nil) maxCount = @(0);
    
    if ([tf isKindOfClass:[NSArray class]]) {
        for (int i = 0; i< [(NSArray *)tf count]; i++) {
            [LWTFHandler handleTextFieldLenghtLimitWithTF:tf[i] maxCount:[(NSArray *)maxCount count] >= i ? maxCount[i] :0];
        }
    }
    UITextField *tf_tem = [[LWTFHandler share] getTF:tf];
    if ([tf_tem isKindOfClass:[UITextField class]]) {
        tf_tem.delegate = [LWTFHandler share];
        [[LWTFHandler share].tfLengthInforCache setObject:maxCount forKey:tf_tem];
    }
}


#pragma mark ********************* 清除缓存 *********************

/**
 根据控制器，清除该控制器下handler的关联缓存信息
 */
+ (void)removeHandlerCacheWithViewController:(UIViewController *)vc
{
    NSArray *btns = [[LWTFHandler share].curVcRelationBtnCache objectForKey:NSStringFromClass(vc.class)];
    for (UIButton *btn in btns) {
        [[LWTFHandler share].relationInforCache removeObjectForKey:btn];
    }
}

/**
 清除 handler的所有按钮状态的关联缓存信息
 */
+ (void)removeAllHandlerCache
{
    [[LWTFHandler share].tfLengthInforCache removeAllObjects];
    [[LWTFHandler share].relationInforCache removeAllObjects];
    [[LWTFHandler share].curVcRelationBtnCache removeAllObjects];
}

#pragma mark ********************* 内部方法 *********************

/**
 获取textfield 兼容项目
 */
- (id)getTF:(id)tfObjc
{
    if ([tfObjc isKindOfClass:[NSArray class]]) {
        NSMutableArray *tfs = [[NSMutableArray alloc] init];
        for (id objc in (NSArray *)tfObjc) {
            if([self getTF:objc] && ![tfs containsObject:[self getTF:objc]]) {
                [tfs addObject:[self getTF:objc]];
            }
        }
        return tfs;
    }
        if ([tfObjc isKindOfClass:[HYBaseTextFiled class]]) {
            [(HYBaseTextFiled *)tfObjc textFiled].delegate = [LWTFHandler share];
            return [(HYBaseTextFiled *)tfObjc textFiled];
        }else if ([tfObjc isKindOfClass:[UITextField class]]){
            UITextField *tftemp = (UITextField *)tfObjc;
            tftemp.delegate = [LWTFHandler share];
            return tfObjc;
        }
    return nil;
}

/**
 根据textfield 修改关联的btn
 
 @param tf 当前改变的textfield
 @param text 当前textfield的改变内容
 */
- (void)handleRelationBtnsState:(UITextField *)tf text:(NSString *)text relationBtn:(UIButton *)relationbtn
{
    __block BOOL res = NO;
    
    [[self.relationInforCache objectForKey:relationbtn] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextField *tf_tem = (UITextField *)obj;
        NSString *text_tem = (tf == tf_tem) ? text : tf_tem.text;
        if (text_tem.length <= 0) {
            *stop = res = YES;
        }
    }];
    relationbtn.enabled = !res;
}
/**
 获取该对象 所在的viewController
 */
- (UIViewController *)getCurrentViewControllerWithObjc:(UIView *)objc
{
    for (UIView *next = [objc superview]; next; next = next.superview) {
        UIResponder *nextResponder                      = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

/**
 根据当前的tf 获取该TF绑定的btn
 
 @param tf 当前输入的tf
 @return 返回绑定的Btn
 */
- (UIButton *)getBtnWithTF:(UITextField *)tf
{
    UIViewController *vc = [self getCurrentViewControllerWithObjc:tf];
    NSArray *btns = [[LWTFHandler share].curVcRelationBtnCache objectForKey:NSStringFromClass(vc.class)];
    for (UIButton *btn in btns) {
        if ([[[LWTFHandler share].relationInforCache objectForKey:btn] containsObject:tf]) {
            return btn;
        };
    }
    return nil;
}

#pragma mark ********************* UITextFieldDelegate *********************

- (BOOL)textFieldShouldClear:(UITextField *)textField
{
    [self handleRelationBtnsState:textField text:@"" relationBtn:[self getBtnWithTF:textField]];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *totalString;
    NSString *tem =  [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] componentsJoinedByString:@""];
    if (![string isEqualToString:tem]) {
        return NO;
    }
    if (string.length <= 0) {
        @try {
            totalString = [textField.text substringToIndex:textField.text.length-1];
        } @catch (NSException *exception) {
        } @finally {}
    }else {
        totalString = [NSString stringWithFormat:@"%@%@",textField.text,string];
    }
    NSInteger maxCont = [[self.tfLengthInforCache objectForKey:textField] integerValue];
    if (maxCont != 0 && totalString.length >= maxCont + 1) {
        return NO;
    }
    
    /** 减少判断的次数 */
    if (totalString.length == 0 || totalString.length == 1) {
        
        /** 保证在未把视图放到控制器上的情况，在此处再次尝试绑定vc-btn */
        if (_relationTempBtn) {
            UIViewController *cvc = [[LWTFHandler share] getCurrentViewControllerWithObjc:textField];
            NSMutableArray *oldbtns =  [[NSMutableArray alloc] initWithArray:[[LWTFHandler share].curVcRelationBtnCache objectForKey:NSStringFromClass(cvc.class)]];
            if(![oldbtns containsObject:_relationTempBtn]) [oldbtns addObject:_relationTempBtn];
            [[LWTFHandler share].curVcRelationBtnCache setObject:oldbtns forKey:NSStringFromClass(cvc.class)];
            _relationTempBtn = nil;
        }
        /** 检查tf 的内容 */
        [self handleRelationBtnsState:textField text:totalString relationBtn:[self getBtnWithTF:textField]];
    }
    return YES;
}

/**
 代理方法的回调接口
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if ([LWTFHandler share].DidEndEditingBlock) {
        [LWTFHandler share].DidEndEditingBlock(textField);
    }
}

#pragma mark ********************* 修改缓存限制 最大值 *********************

/** 修改tf信息缓存的最大值 默认10 */
- (void)setTfLenghtCacheLimit:(NSInteger)tfLenghtCacheLimit
{
    [LWTFHandler share].tfLengthInforCache.countLimit = tfLenghtCacheLimit;
}
/** <key:btn, value:tfs> btn管理tfs数组的缓存 默认 10 */
-(void)setRelationInforCacheLimit:(NSInteger)relationInforCacheLimit
{
    [LWTFHandler share].relationInforCache.countLimit = relationInforCacheLimit;
}
/** 控制器栈的限制 最大默认 5 */
- (void)setViewControllerStackLimit:(NSInteger)viewControllerStackLimit
{
    [LWTFHandler share].curVcRelationBtnCache.countLimit = viewControllerStackLimit;
}
@end
