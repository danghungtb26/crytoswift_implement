
    //
    //  SecurePasswordTextFieldManager.m
    //  weavr-ux-components
    //
    //  Created by Tareq Islam on 17/8/22.
    //

#import <Foundation/Foundation.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(SecureCardPinLabelManager, RCTViewManager)
RCT_EXPORT_VIEW_PROPERTY(fontStyle, NSDictionary)
RCT_EXPORT_VIEW_PROPERTY(backgroundViewColor, NSString)
RCT_EXPORT_VIEW_PROPERTY(textColor, NSString)
RCT_EXPORT_VIEW_PROPERTY(textSize, NSString)

RCT_EXPORT_VIEW_PROPERTY(copyOnClick, BOOL)
RCT_EXPORT_VIEW_PROPERTY(copyOnLongClick, BOOL)


RCT_EXPORT_VIEW_PROPERTY(onCreateTokenAction, RCTDirectEventBlock)
RCT_EXTERN_METHOD(deTokenize: (nonnull NSNumber *) reactTag
                  toDetokenize: (NSString *)toDetokenize
                  )
RCT_EXPORT_VIEW_PROPERTY(onCopyToClipboardAction, RCTDirectEventBlock)
@end
