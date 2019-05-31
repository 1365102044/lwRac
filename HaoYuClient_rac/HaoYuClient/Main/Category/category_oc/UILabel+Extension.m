//
//  UILabel+Extension.m
//  inborn
//
//  Created by 郑键 on 17/3/16.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import "UILabel+Extension.h"

@implementation UILabel (Extension)

/**
 添加删除线
 */
- (void)strikeLableWith:(NSString *)textStr
{
    //中划线
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:textStr];
    [attribtStr addAttributes:@{
                             NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick),
                             NSForegroundColorAttributeName:
                                 [UIColor lightGrayColor],
                             NSBaselineOffsetAttributeName:
                                 @(0),
                             NSFontAttributeName: [UIFont systemFontOfSize:14]
                             } range:NSMakeRange(0, textStr.length)];
    self.attributedText = attribtStr;
    
}

/**
 *  设置行距
 */
- (void)setRowSpace:(CGFloat)rowSpace
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    paragraphStyle.alignment = self.textAlignment;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}

- (void)setMultipleRowSpace:(CGFloat)rowSpace
{
    if ([self.text ex_getSpaceLabelHeightwithSpeace:rowSpace withFont:self.font withWidth:self.width] > [@"一行" ex_getSpaceLabelHeightwithSpeace:ADJUST_PERCENT_FLOAT(9.f) withFont:SYSTEM_MEDIUMFONT(12.f) withWidth:self.width]) {
        [self setRowSpace:rowSpace];
    }
}

- (void)setTextWithLinkAttribute:(NSString *)text {
    self.attributedText = [self
                           subStr:text];
}

- (NSMutableAttributedString *)subStr:(NSString *)string
{
    NSError *error;
    //可以识别url的正则表达式
    NSString *regulaStr =
    @"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    NSRegularExpression *regex = [NSRegularExpression
                                  regularExpressionWithPattern:regulaStr
                                  
                                  options:NSRegularExpressionCaseInsensitive
                                  
                                  error:&error];
    NSArray *arrayOfAllMatches = [regex
                                  matchesInString:string options:0
                                  range:NSMakeRange(0, [string
                                                        length])];
    NSMutableArray *arr=[[NSMutableArray
                          alloc]init];
    NSMutableArray *rangeArr=[[NSMutableArray
                               alloc]init];
    
    for (NSTextCheckingResult *match
         in arrayOfAllMatches)
    {
        NSString* substringForMatch;
        substringForMatch = [string substringWithRange:match.range];
        [arr addObject:substringForMatch];
        
    }
    NSString *subStr=string;
    for (NSString *str
         in arr) {
        [rangeArr addObject:[self
                             rangesOfString:str inString:subStr]];
    }
    UIFont *font = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    NSMutableAttributedString *attributedText;
    attributedText=[[NSMutableAttributedString
                     alloc]initWithString:subStr
                    attributes:@{NSFontAttributeName :font}];
    
    for(NSValue *value
        in rangeArr)
    {
        NSInteger index=[rangeArr
                         indexOfObject:value];
        NSRange range=[value
                       rangeValue];
        [attributedText addAttribute:NSLinkAttributeName
                               value:[NSURL
                                      URLWithString:[arr objectAtIndex:index]]
                               range:range];
        [attributedText addAttribute:NSForegroundColorAttributeName
                               value:[UIColor
                                      blueColor] range:range];
        
    }
    return attributedText;
    
    
}
//获取查找字符串在母串中的NSRange
- (NSValue *)rangesOfString:(NSString *)searchString inString:(NSString *)str {
    
    NSRange searchRange =
    NSMakeRange(0, [str
                    length]);
    
    NSRange range;
    
    if ((range = [str
                  rangeOfString:searchString  options:0
                  range:searchRange]).location !=
        NSNotFound) {
        searchRange = NSMakeRange(NSMaxRange(range), [str
                                                      length] - NSMaxRange(range));
    }
    return [NSValue
            valueWithRange:range];
}

@end
