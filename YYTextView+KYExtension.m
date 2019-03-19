//
//  YYTextView+KYExtension.m
//  TestDemo
//
//  Created by Siding on 2019/1/24.
//  Copyright © 2019 Siding. All rights reserved.
//

#import "YYTextView+KYExtension.h"

#import "NSAttributedString+KYExtension.h"

@implementation YYTextView (KYExtension)

- (void)insertAttributedStringAtCursor:(NSAttributedString *)str {
    if (!str) return;
    
    NSRange selectedRange = self.selectedRange;
    NSMutableAttributedString *attributedString = [self.attributedText mutableCopy];
    
    if (attributedString) {
        [attributedString replaceCharactersInRange:self.selectedRange withAttributedString:str];
        self.attributedText = [attributedString copy];
    } else {
        self.attributedText = [str copy];
    }
    
    self.selectedRange = NSMakeRange(selectedRange.location + [str length], 0);
}

- (void)insertAttachmentAtCursor:(id)attachment size:(CGSize)size {
    if (!attachment) return;
    
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:attachment size:size];
    [self insertAttributedStringAtCursor:attributedString];
}

- (void)deleteAttachmentInRange:(NSRange)range {
    NSMutableAttributedString *attributedString = [self.attributedText mutableCopy];
    if (attributedString) {
        [attributedString deleteCharactersInRange:range];
        self.attributedText = attributedString.copy;
    }
}

- (void)updateOldAttachment:(id)oldAttachment newAttachment:(id)newAttachment size:(CGSize)size {
    if (!oldAttachment) return;
    
    __block NSRange replaceRange = NSMakeRange(0, 0);
    [self.attributedText enumerateAttribute:YYTextAttachmentAttributeName inRange:NSMakeRange(0, [self.attributedText length]) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if ([value isMemberOfClass:[YYTextAttachment class]]) {
            YYTextAttachment *textAttachment = (YYTextAttachment *)value;
            if ([textAttachment.content isEqualToString:oldAttachment]) {
                replaceRange = range;
                *stop = YES;
            }
        }
    }];
    
    if (replaceRange.length == 0) return;
    
    NSMutableAttributedString *attributedString = [self.attributedText mutableCopy];
    NSAttributedString *newAttachmentAttributedString = [NSAttributedString attributedStringWithAttachment:newAttachment size:size];
    [attributedString replaceCharactersInRange:replaceRange withAttributedString:newAttachmentAttributedString];
    self.attributedText = attributedString.copy;
}

#pragma mark -

- (NSArray *)attachmentArrayWithClass:(Class)aClass {
    __block NSMutableArray *attachmentArray;
    [self.attributedText enumerateAttribute:YYTextAttachmentAttributeName inRange:NSMakeRange(0, [self.attributedText length]) options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired usingBlock:^(id  _Nullable value, NSRange range, BOOL * _Nonnull stop) {
        if ([value isMemberOfClass:[YYTextAttachment class]]) {
            YYTextAttachment *textAttachment = (YYTextAttachment *)value;
            if ([textAttachment.content isMemberOfClass:aClass]) {
                if (!attachmentArray) attachmentArray = @[].mutableCopy;
                [attachmentArray addObject:textAttachment.content];
            }
        }
    }];
    
    return attachmentArray.copy;
}

@end
