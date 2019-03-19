//
//  NSAttributedString+KYExtension.m
//  TestDemo
//
//  Created by Siding on 2019/1/24.
//  Copyright © 2019 Siding. All rights reserved.
//

#import "NSAttributedString+KYExtension.h"
#import <NSAttributedString+YYText.h>

@implementation NSAttributedString (KYExtension)

+ (NSAttributedString *)attributedStringWithAttachment:(id)attachment size:(CGSize)size {
    NSAttributedString *attributedString;
    
    if ([attachment isKindOfClass:[UIImage class]]) {
        attributedString = [NSAttributedString yy_attachmentStringWithContent:attachment contentMode:UIViewContentModeScaleToFill width:size.width ascent:size.height descent:0];
    } else if ([attachment isKindOfClass:[UIView class]]) {
        attributedString = [NSAttributedString yy_attachmentStringWithContent:attachment contentMode:UIViewContentModeLeft width:size.width ascent:size.height descent:0];
    }
    
    return attributedString;
}

@end
