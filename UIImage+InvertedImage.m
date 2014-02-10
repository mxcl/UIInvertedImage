#import "UIImage+InvertedImage.h"


@implementation UIImage (InvertedImage)

- (UIImage *)invertedImage {
    CGRect rect = (CGRect){.size = self.size};
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGContextSetBlendMode(ctx, kCGBlendModeCopy);
    [self drawInRect:rect];
    CGContextSetBlendMode(ctx, kCGBlendModeDifference);

    // transform from CG coords to UI coords
    CGContextTranslateCTM(ctx, 0, self.size.height);
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
