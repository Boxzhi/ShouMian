//
//  UIView+HZZAddForRoundedCorner.m
//  Shoumian
//
//  Created by 何志志 on 2017/3/10.
//  Copyright © 2017年 何志志. All rights reserved.
//

#import "UIView+HZZAddForRoundedCorner.h"
#import <objc/runtime.h>

@implementation UIColor(Components)

- (NSString *)colorComponent {
    
    CGColorRef cgColor = self.CGColor;
    
    const CGFloat *colorComponents = CGColorGetComponents(cgColor);
    
    CGFloat r = colorComponents[0];
    CGFloat g = colorComponents[1];
    CGFloat b = colorComponents[2];
    
    NSString *result = [NSString stringWithFormat:@"r%f_g%f_b%f", r, g, b];
    return result;
}

@end

#pragma mark - --
@implementation NSObject (_HZZAdd)

+ (void)hzz_swizzleInstanceMethod:(SEL)originalSel with:(SEL)newSel {
    Method originalMethod = class_getInstanceMethod(self, originalSel);
    Method newMethod = class_getInstanceMethod(self, newSel);
    if (!originalMethod || !newMethod) return;
    method_exchangeImplementations(originalMethod, newMethod);
}

- (void)hzz_setAssociateValue:(id)value withKey:(void *)key {
    objc_setAssociatedObject(self, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)hzz_getAssociatedValueForKey:(void *)key {
    return objc_getAssociatedObject(self, key);
}

- (void)hzz_removeAssociateWithKey:(void *)key {
    objc_setAssociatedObject(self, key, nil, OBJC_ASSOCIATION_ASSIGN);
}

@end

#pragma mark - --
@implementation UIImage (HZZAddForRoundedCorner)

+ (UIImage *)hzz_imageWithSize:(CGSize)size drawBlock:(void (^)(CGContextRef context))drawBlock {
    if (!drawBlock) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if (!context) return nil;
    drawBlock(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)hzz_maskRoundCornerRadiusImageWithColor:(UIColor *)color cornerRadii:(CGSize)cornerRadii size:(CGSize)size corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    return [UIImage hzz_imageWithSize:size drawBlock:^(CGContextRef  _Nonnull context) {
        CGContextSetLineWidth(context, 0);
        [color set];
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        UIBezierPath *rectPath = [UIBezierPath bezierPathWithRect:CGRectInset(rect, -0.3, -0.3)];
        UIBezierPath *roundPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, 0.3, 0.3) byRoundingCorners:corners cornerRadii:cornerRadii];
        [rectPath appendPath:roundPath];
        CGContextAddPath(context, rectPath.CGPath);
        CGContextEOFillPath(context);
        if (!borderColor || !borderWidth) return;
        [borderColor set];
        UIBezierPath *borderOutterPath = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:cornerRadii];
        UIBezierPath *borderInnerPath = [UIBezierPath bezierPathWithRoundedRect:CGRectInset(rect, borderWidth, borderWidth) byRoundingCorners:corners cornerRadii:cornerRadii];
        [borderOutterPath appendPath:borderInnerPath];
        CGContextAddPath(context, borderOutterPath.CGPath);
        CGContextEOFillPath(context);
    }];
}

@end



static void *const _HZZMaskCornerRadiusLayerKey = "_HZZMaskCornerRadiusLayerKey";
static NSMutableSet<UIImage *> *maskCornerRaidusImageSet;
#pragma mark - --
@implementation CALayer (HZZAddForRoundedCorner)

+ (void)load{
    [CALayer hzz_swizzleInstanceMethod:@selector(layoutSublayers) with:@selector(_hzz_layoutSublayers)];
}

- (UIImage *)contentImage{
    return [UIImage imageWithCGImage:(__bridge CGImageRef)self.contents];
}

- (void)setContentImage:(UIImage *)contentImage{
    self.contents = (__bridge id)contentImage.CGImage;
}

- (void)hzz_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color{
    [self hzz_roundedCornerWithRadius:radius cornerColor:color corners:UIRectCornerAllCorners];
}

- (void)hzz_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners{
    [self hzz_roundedCornerWithCornerRadii:CGSizeMake(radius, radius) cornerColor:color corners:corners borderColor:nil borderWidth:0];
}

- (void)hzz_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    if (!color) return;
    CALayer *cornerRadiusLayer = [self hzz_getAssociatedValueForKey:_HZZMaskCornerRadiusLayerKey];
    if (!cornerRadiusLayer) {
        cornerRadiusLayer = [CALayer new];
        cornerRadiusLayer.opaque = YES;
        [self hzz_setAssociateValue:cornerRadiusLayer withKey:_HZZMaskCornerRadiusLayerKey];
    }
    if (color) {
        [cornerRadiusLayer hzz_setAssociateValue:color withKey:"_hzz_cornerRadiusImageColor"];
    }else{
        [cornerRadiusLayer hzz_removeAssociateWithKey:"_hzz_cornerRadiusImageColor"];
    }
    [cornerRadiusLayer hzz_setAssociateValue:[NSValue valueWithCGSize:cornerRadii] withKey:"_hzz_cornerRadiusImageRadius"];
    [cornerRadiusLayer hzz_setAssociateValue:@(corners) withKey:"_hzz_cornerRadiusImageCorners"];
    if (borderColor) {
        [cornerRadiusLayer hzz_setAssociateValue:borderColor withKey:"_hzz_cornerRadiusImageBorderColor"];
    }else{
        [cornerRadiusLayer hzz_removeAssociateWithKey:"_hzz_cornerRadiusImageBorderColor"];
    }
    [cornerRadiusLayer hzz_setAssociateValue:@(borderWidth) withKey:"_hzz_cornerRadiusImageBorderWidth"];
    UIImage *image = [self _hzz_getCornerRadiusImageFromSet];
    if (image) {
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = image;
        [CATransaction commit];
    }
    
}

- (UIImage *)_hzz_getCornerRadiusImageFromSet{
    if (!self.bounds.size.width || !self.bounds.size.height) return nil;
    CALayer *cornerRadiusLayer = [self hzz_getAssociatedValueForKey:_HZZMaskCornerRadiusLayerKey];
    UIColor *color = [cornerRadiusLayer hzz_getAssociatedValueForKey:"_hzz_cornerRadiusImageColor"];
    if (!color) return nil;
    CGSize radius = [[cornerRadiusLayer hzz_getAssociatedValueForKey:"_hzz_cornerRadiusImageRadius"] CGSizeValue];
    NSUInteger corners = [[cornerRadiusLayer hzz_getAssociatedValueForKey:"_hzz_cornerRadiusImageCorners"] unsignedIntegerValue];
    CGFloat borderWidth = [[cornerRadiusLayer hzz_getAssociatedValueForKey:"_hzz_cornerRadiusImageBorderWidth"] floatValue];
    UIColor *borderColor = [cornerRadiusLayer hzz_getAssociatedValueForKey:"_hzz_cornerRadiusImageBorderColor"];
    if (!maskCornerRaidusImageSet) {
        maskCornerRaidusImageSet = [NSMutableSet new];
    }
    __block UIImage *image = nil;
    [maskCornerRaidusImageSet enumerateObjectsUsingBlock:^(UIImage * _Nonnull obj, BOOL * _Nonnull stop) {
        CGSize imageSize = [[obj hzz_getAssociatedValueForKey:"_hzz_cornerRadiusImageSize"] CGSizeValue];
        UIColor *imageColor = [obj hzz_getAssociatedValueForKey:"_hzz_cornerRadiusImageColor"];
        CGSize imageRadius = [[obj hzz_getAssociatedValueForKey:"_hzz_cornerRadiusImageRadius"] CGSizeValue];
        NSUInteger imageCorners = [[obj hzz_getAssociatedValueForKey:"_hzz_cornerRadiusImageCorners"] unsignedIntegerValue];
        CGFloat imageBorderWidth = [[obj hzz_getAssociatedValueForKey:"_hzz_cornerRadiusImageBorderWidth"] floatValue];
        UIColor *imageBorderColor = [obj hzz_getAssociatedValueForKey:"_hzz_cornerRadiusImageBorderColor"];
        BOOL isBorderSame = (CGColorEqualToColor(borderColor.CGColor, imageBorderColor.CGColor) && borderWidth == imageBorderWidth) || (!borderColor && !imageBorderColor) || (!borderWidth && !imageBorderWidth);
        BOOL canReuse = CGSizeEqualToSize(self.bounds.size, imageSize) && CGColorEqualToColor(imageColor.CGColor, color.CGColor) && imageCorners == corners && CGSizeEqualToSize(radius, imageRadius) && isBorderSame;
        if (canReuse) {
            image = obj;
            *stop = YES;
        }
    }];
    if (!image) {
        image = [UIImage hzz_maskRoundCornerRadiusImageWithColor:color cornerRadii:radius size:self.bounds.size corners:corners borderColor:borderColor borderWidth:borderWidth];
        [image hzz_setAssociateValue:[NSValue valueWithCGSize:self.bounds.size] withKey:"_hzz_cornerRadiusImageSize"];
        [image hzz_setAssociateValue:color withKey:"_hzz_cornerRadiusImageColor"];
        [image hzz_setAssociateValue:[NSValue valueWithCGSize:radius] withKey:"_hzz_cornerRadiusImageRadius"];
        [image hzz_setAssociateValue:@(corners) withKey:"_hzz_cornerRadiusImageCorners"];
        if (borderColor) {
            [image hzz_setAssociateValue:color withKey:"_hzz_cornerRadiusImageBorderColor"];
        }
        [image hzz_setAssociateValue:@(borderWidth) withKey:"_hzz_cornerRadiusImageBorderWidth"];
        [maskCornerRaidusImageSet addObject:image];
    }
    return image;
}

#pragma mark - exchage Methods

- (void)_hzz_layoutSublayers{
    [self _hzz_layoutSublayers];
    CALayer *cornerRadiusLayer = [self hzz_getAssociatedValueForKey:_HZZMaskCornerRadiusLayerKey];
    if (cornerRadiusLayer) {
        UIImage *aImage = [self _hzz_getCornerRadiusImageFromSet];
        [CATransaction begin];
        [CATransaction setDisableActions:YES];
        cornerRadiusLayer.contentImage = aImage;
        cornerRadiusLayer.frame = self.bounds;
        [CATransaction commit];
        [self addSublayer:cornerRadiusLayer];
    }
}

@end


@implementation UIView (HZZAddForRoundedCorner)

- (void)hzz_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color{
    [self.layer hzz_roundedCornerWithRadius:radius cornerColor:color];
}

- (void)hzz_roundedCornerWithRadius:(CGFloat)radius cornerColor:(UIColor *)color corners:(UIRectCorner)corners{
    [self.layer hzz_roundedCornerWithRadius:radius cornerColor:color corners:corners];
}

- (void)hzz_roundedCornerWithCornerRadii:(CGSize)cornerRadii cornerColor:(UIColor *)color corners:(UIRectCorner)corners borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth{
    [self.layer hzz_roundedCornerWithCornerRadii:cornerRadii cornerColor:color corners:corners borderColor:borderColor borderWidth:borderWidth];
}



/**
 *  另一种设置圆角方法
 */
- (void)addImageWithCornerRadius:(CGFloat)radius color:(UIColor *)color {
    __weak __typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf addImageWithCornerRadius:radius color:color size:weakSelf.bounds.size];
    });
}

- (void)addImageWithCornerRadius:(CGFloat)radius color:(UIColor *)color size:(CGSize)size {
    
    // 根据颜色，圆角程度，尺寸 命名文件
    NSString *name = [NSString stringWithFormat:@"%@_%f_%@.png", [color colorComponent], radius, NSStringFromCGSize(size)];
    NSString *fullPath = [[self pathWithFolder:@"CornerRadius"] stringByAppendingPathComponent:name];
    
    // 判断本地是否已经有缓存了
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isExists = [fileManager fileExistsAtPath:fullPath];
    UIImage *image;
    if (isExists) {
        // 从缓存中获取
        image = [UIImage imageNamed:fullPath];
    } else {
        // 缓存中没有 -> 生成图片 -> 保存
        image = [self getImageWithSize:size color:color radius:radius];
        NSData *data = UIImagePNGRepresentation(image);
        [data writeToFile:fullPath atomically:YES];
    }
    // 讲生成的图片覆盖到当前的图层上
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.frame = CGRectMake(0, 0, size.width, size.height);
    [self addSubview:imageView];
}

- (UIImage *)getImageWithSize:(CGSize)size color:(UIColor *)color radius:(CGFloat)radius {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    UIBezierPath *aPath = [UIBezierPath bezierPathWithRect:CGRectMake(0,0,size.width,size.height)];
    UIBezierPath *bPath = [UIBezierPath bezierPathWithRoundedRect:aPath.bounds cornerRadius:radius];
    [aPath appendPath:[bPath bezierPathByReversingPath]];
    [color setFill];
    [aPath fill];
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (NSString *)pathWithFolder:(NSString *)folder {
    
    NSString *documentPath = [self documentPath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *folderPath = [documentPath stringByAppendingPathComponent:folder];
    BOOL isExist = [fileManager fileExistsAtPath:folderPath];
    if (!isExist) {
        [fileManager createDirectoryAtPath:folderPath
               withIntermediateDirectories:YES
                                attributes:nil
                                     error:nil];
    }
    return folderPath;
}

- (NSString *)documentPath {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    return path;
}

@end
