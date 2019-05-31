//
//  HYAnnotationView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/16.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYAnnotationView.h"
#import "HYPointAnnotation.h"
@implementation HYAnnotationView

- (instancetype)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier]) {
    }
    return self;
}

+ (instancetype)annotationViewWithMap:(BMKMapView *)mapView withAnnotation:(id <BMKAnnotation>)annotation {
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        static NSString *identifier = @"annotation";
        // 1.从缓存池中取
        HYAnnotationView *annoView = (HYAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        // 2.如果缓存池中没有, 创建一个新的
        if (annoView == nil) {
            annoView = [[HYAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        }
        if ([annotation isKindOfClass:[HYPointAnnotation class]]) {
            annoView.annotation = (HYPointAnnotation *)annotation;
        }
        annoView.image = [UIImage imageNamed:@"annotion_icon"];
        return annoView;
    }
    return nil;
}

@end
