//
//  YYTextView+KYExtension.h
//  TestDemo
//
//  Created by Siding on 2019/1/24.
//  Copyright © 2019 Siding. All rights reserved.
//

#import "YYTextView.h"

NS_ASSUME_NONNULL_BEGIN

@interface YYTextView (KYExtension)

- (void)insertAttributedStringAtCursor:(NSAttributedString *)str;
- (void)insertAttachmentAtCursor:(id)attachment size:(CGSize)size;
- (void)deleteAttachmentInRange:(NSRange)range;
- (void)updateOldAttachment:(id)oldAttachment newAttachment:(id)newAttachment size:(CGSize)size;

#pragma mark -

- (NSArray *)attachmentArrayWithClass:(Class)aClass;

@end

NS_ASSUME_NONNULL_END
