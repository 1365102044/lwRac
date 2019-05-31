//
//  UIImage+Extension.m
//  Project
//
//  Created by 郑键 on 17/1/11.
//  Copyright © 2017年 zhengjian. All rights reserved.
//

#import "UIImage+Extension.h"
#import <AVFoundation/AVFoundation.h>

#import <Accelerate/Accelerate.h>
@implementation UIImage (Extension)

/**
 *  绘制圆形图片
 *
 *  @return 返回圆角图片
 */
- (instancetype)ex_drawCircleImage
{
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context        = UIGraphicsGetCurrentContext();
    CGRect rect                 = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [self drawInRect:rect];
    UIImage *image              = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  改变图片颜色
 *
 *  @param color 希望修改的颜色
 *
 *  @return 修改颜色后的图片
 */
- (UIImage *)ex_imageWithColor:(UIColor *)color
{
    UIGraphicsBeginImageContextWithOptions(self.size, NO, self.scale);
    CGContextRef context            = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, self.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGRect rect                     = CGRectMake(0, 0, self.size.width, self.size.height);
    CGContextClipToMask(context, rect, self.CGImage);
    [color setFill];
    CGContextFillRect(context, rect);
    UIImage*newImage                = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  拍照上传出现图片旋转现象，为图片添加方向
 *
 *  @return 返回正常方向的图片
 */
- (UIImage *)ex_fixOrientation
{
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    CGAffineTransform transform             = CGAffineTransformIdentity;
    switch(self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform                       = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform                       = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform                       = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform                       = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform                       = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform                       = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch(self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform                       = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform                       = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform                       = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform                       = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    CGContextRef ctx                        = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                                                    CGImageGetBitsPerComponent(self.CGImage),
                                                                    0,
                                                                    CGImageGetColorSpace(self.CGImage),
                                                                    CGImageGetBitmapInfo(self.CGImage));
    
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    CGImageRef cgimg                        = CGBitmapContextCreateImage(ctx);
    UIImage *img                            = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    
    return img;
    
}

/**
 *  根据尺寸压缩图片
 *
 *  @param size 要压缩的尺寸
 *
 *  @return 压缩后的图片
 */
- (UIImage*)ex_originWithScaleToSize:(CGSize)size
{
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, NO, SCREEN_SCALE);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage* scaledImage                    = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}

/**
 *  从图片中按指定的位置大小截取图片的一部分
 *
 *  @param image 要截取的图片
 *  @param rect 截取的范围
 *  @param scale 屏幕缩放因子范围1~3，UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale)配合使用，当图片按照固定尺寸重绘后，截取时，需要对应图片的缩放因子
 *  @return 截取后的图片
 */
- (UIImage *)ex_imageFromImage:(UIImage *)image
                        inRect:(CGRect)rect
                         scale:(CGFloat)scale
{
    CGImageRef sourceImageRef               = [image CGImage];
    CGRect currentImageReact                = CGRectMake(rect.origin.x * scale,
                                                         rect.origin.y * scale,
                                                         rect.size.width * scale,
                                                         rect.size.height * scale);
    CGImageRef newImageRef                  = CGImageCreateWithImageInRect(sourceImageRef,
                                                                           currentImageReact);
    UIImage *newImage                       = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}

/**
 *  将占位图片绘制在当前图片中央
 *
 *  @param image           image 居中的logo图片
 *  @param size            size 当前需要施画的范围
 *  @param backgroundColor backgroundColor 背景画布颜色
 *
 *  @return 绘制好的logo居中图片
 */
+ (UIImage *)ex_drawImage:(UIImage*)image
                     size:(CGSize)size
          backgroundColor:(UIColor *)backgroundColor
{
    UIGraphicsBeginImageContextWithOptions(size, 0, [UIScreen mainScreen].scale);
    [backgroundColor set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    CGFloat imageX                          = (size.width / 2) - (image.size.width / 2);
    CGFloat imageY                          = (size.height / 2) - (image.size.height / 2);
    [image drawInRect:CGRectMake(imageX,
                                 imageY,
                                 image.size.width,
                                 image.size.height)];
    UIImage *resImage                       = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;
}

/**
 *  指定图片拉伸区域
 *
 *  @param top          top
 *  @param bottom       bottom
 *  @param left         left
 *  @param right        right
 *  @return             返回指定拉伸区域的图片
 */
- (UIImage *)ex_resizableImageWithTop:(CGFloat)top
                               bottom:(CGFloat)bottom
                                 left:(CGFloat)left
                                right:(CGFloat)right
{
    UIEdgeInsets insets = UIEdgeInsetsMake(top, left, bottom, right);
    return [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

#pragma mark - 条码二维码生成

+ (UIImage *)resizeImageWithoutInterpolation:(UIImage *)sourceImage size:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextSetInterpolationQuality(UIGraphicsGetCurrentContext(), kCGInterpolationNone);
    [sourceImage drawInRect:(CGRect){.size = size}];
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return result;
}

+ (UIImage *)imageWithCIImage:(CIImage *)aCIImage orientation: (UIImageOrientation)anOrientation
{
    if (!aCIImage) return nil;
    
    CGImageRef imageRef = [[CIContext contextWithOptions:nil] createCGImage:aCIImage fromRect:aCIImage.extent];
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:1.0 orientation:anOrientation];
    CFRelease(imageRef);
    
    return image;
}

/**
 *  二维码生成
 */
+ (UIImage *)qrImageWithString:(NSString *)string
                          size:(CGSize)size
                         color:(UIColor *)color
               backGroundColor:(UIColor *)backGroundColor
{
    if (!string) {
        return nil;
    }
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    if (!qrFilter)
    {
        NSLog(@"Error: Could not load filter");
        return nil;
    }
    
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    
    
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    CIFilter * colorQRFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [colorQRFilter setValue:qrFilter.outputImage forKey:@"inputImage"];
    //二维码颜色
    if (color == nil) {
        color = [UIColor blackColor];
    }
    if (backGroundColor == nil) {
        backGroundColor = [UIColor whiteColor];
    }
    [colorQRFilter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor0"];
    //背景颜色
    [colorQRFilter setValue:[CIColor colorWithCGColor:backGroundColor.CGColor] forKey:@"inputColor1"];
    
    
    CIImage *outputImage = [colorQRFilter valueForKey:@"outputImage"];
    
    UIImage *smallImage = [self imageWithCIImage:outputImage orientation: UIImageOrientationUp];
    
    return [self resizeImageWithoutInterpolation:smallImage size:size];
}
//条形码生成
+ (UIImage *)generateBarCode:(NSString *)code size:(CGSize)size color:(UIColor *)color backGroundColor:(UIColor *)backGroundColor{
    // 生成条形码图片
    CIImage *barcodeImage;
    NSData *data = [code dataUsingEncoding:NSISOLatin1StringEncoding allowLossyConversion:false];
    CIFilter *filter = [CIFilter filterWithName:@"CICode128BarcodeGenerator"];
    [filter setValue:data forKey:@"inputMessage"];
    //设置条形码颜色和背景颜色
    CIFilter * colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [colorFilter setValue:filter.outputImage forKey:@"inputImage"];
    //条形码颜色
    if (color == nil) {
        color = [UIColor blackColor];
    }
    if (backGroundColor == nil) {
        backGroundColor = [UIColor whiteColor];
    }
    [colorFilter setValue:[CIColor colorWithCGColor:color.CGColor] forKey:@"inputColor0"];
    //背景颜色
    [colorFilter setValue:[CIColor colorWithCGColor:backGroundColor.CGColor] forKey:@"inputColor1"];
    
    barcodeImage = [colorFilter outputImage];
    
    // 消除模糊
    CGFloat scaleX = size.width / barcodeImage.extent.size.width; // extent 返回图片的frame
    CGFloat scaleY = size.height / barcodeImage.extent.size.height;
    CIImage *transformedImage = [barcodeImage imageByApplyingTransform:CGAffineTransformScale(CGAffineTransformIdentity, scaleX, scaleY)];
    
    return [UIImage imageWithCIImage:transformedImage];
}

/**
 *  高斯模糊 CoreImage
 */
+ (UIImage *)coreBlurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage= [CIImage imageWithCGImage:image.CGImage];
    //设置filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey]; [filter setValue:@(blur) forKey: @"inputRadius"];
    //模糊图片
    CIImage *result=[filter valueForKey:kCIOutputImageKey];
    CGImageRef outImage=[context createCGImage:result fromRect:[result extent]];
    UIImage *blurImage=[UIImage imageWithCGImage:outImage];
    CGImageRelease(outImage);
    return blurImage;
}
/**
 *  vImage
 */
+ (UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur
{
    if (blur < 0.f || blur > 1.f) {
        blur = 0.5f;
    }
    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    //从CGImage中获取数据
    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    //设置从CGImage获取对象的属性
    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void*)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    if(pixelBuffer == NULL)
        NSLog(@"No pixelbuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate( outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage (ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];
    //clean up CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpace);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}

/**
 获取视频帧图片

 @param videoURL        视频url
 @param time            时间
 @return                图片
 */
+ (UIImage*)ex_thumbnailImageForVideo:(NSURL *)videoURL atTime:(NSTimeInterval)time
{
    AVURLAsset *asset                                   = [[AVURLAsset alloc] initWithURL:videoURL options:nil];
    NSParameterAssert(asset);
    AVAssetImageGenerator *assetImageGenerator          =[[AVAssetImageGenerator alloc] initWithAsset:asset];
    assetImageGenerator.appliesPreferredTrackTransform  = YES;
    assetImageGenerator.apertureMode                    = AVAssetImageGeneratorApertureModeEncodedPixels;
    
    CGImageRef thumbnailImageRef                        = NULL;
    CFTimeInterval thumbnailImageTime                   = time;
    NSError *thumbnailImageGenerationError              = nil;
    thumbnailImageRef                                   = [assetImageGenerator copyCGImageAtTime:CMTimeMake(thumbnailImageTime,
                                                                                                            60)
                                                                                      actualTime:NULL
                                                                                           error:&thumbnailImageGenerationError];
    
    if(!thumbnailImageRef)
        NSLog(@"thumbnailImageGenerationError %@",thumbnailImageGenerationError);
    
    UIImage*thumbnailImage                              = thumbnailImageRef ? [[UIImage alloc]initWithCGImage: thumbnailImageRef] : nil;
    
    return thumbnailImage;
}

@end
