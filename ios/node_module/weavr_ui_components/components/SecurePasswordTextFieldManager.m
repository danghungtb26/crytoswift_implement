//
//  SecurePasswordTextFieldManager.m
//  weavr-ux-components
//
//  Created by Tareq Islam on 17/8/22.
//

#import <Foundation/Foundation.h>
#import <React/RCTViewManager.h>

@interface RCT_EXTERN_MODULE(SecurePasswordTextFieldManager, RCTViewManager)
    RCT_EXPORT_VIEW_PROPERTY(fontStyle, NSDictionary)
    RCT_EXPORT_VIEW_PROPERTY(backgroundViewColor, NSString)
    RCT_EXPORT_VIEW_PROPERTY(placeholder, NSString)
    RCT_EXPORT_VIEW_PROPERTY(placeholderTextColor, NSString)
    RCT_EXPORT_VIEW_PROPERTY(textSize, NSString)

    RCT_EXPORT_VIEW_PROPERTY(background, BOOL)

    RCT_EXTERN_METHOD(initUxComponents:
                  (RCTPromiseResolveBlock)resolve
                  )
    RCT_EXPORT_VIEW_PROPERTY(onCreateTokenAction, RCTDirectEventBlock)

    RCT_EXTERN_METHOD(createToken:
                      (nonnull NSNumber *) reactTag
                  )

    RCT_EXPORT_VIEW_PROPERTY(onGetTagAction, RCTDirectEventBlock)

    RCT_EXTERN_METHOD(getTag:
                  (nonnull NSNumber *) reactTag
                  )
     RCT_EXPORT_VIEW_PROPERTY(onTextChangesAction, RCTDirectEventBlock)
RCT_EXPORT_VIEW_PROPERTY(onFocusAction, RCTDirectEventBlock)
@end
