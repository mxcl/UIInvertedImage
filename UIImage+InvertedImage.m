#import "UIImage+InvertedImage.h"


@implementation UIImage (InvertedImage)

- (UIImage *)invertedImage {
    CGRect rect = (CGRect){.size = self.size};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, self.scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextSetBlendMode(ctx, kCGBlendModeCopy);
    [self drawInRect:rect];
    CGContextSetBlendMode(ctx, kCGBlendModeDifference);

    // transform from CG coords to UI coords
    CGContextTranslateCTM(ctx, 0, rect.size.height);
    CGContextScaleCTM(ctx, 1.0, -1.0);

    // mask it
    CGContextClipToMask(ctx, rect, self.CGImage);
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextFillRect(ctx, rect);

    UIImage *rv = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return rv;
}

@end
