//
//  MXCommonUI.m
//  AnimationStudy
//
//  Created by mingxing on 2020/5/27.
//  Copyright © 2020 Star. All rights reserved.
//

#import "MXCommonUI.h"
#import "MXUIHelper.h"

NSString *const MXSelectedThemeIdentifier = @"selectedThemeIdentifier";
NSString *const MXThemeIdentifierDefault = @"Default";
NSString *const MXThemeIdentifierGrapefruit = @"Grapefruit";
NSString *const MXThemeIdentifierGrass = @"Grass";
NSString *const MXThemeIdentifierPinkRose = @"Pink Rose";
NSString *const MXThemeIdentifierDark = @"Dark";

const CGFloat MXButtonSpacingHeight = 72;

@implementation MXCommonUI

+ (void)renderGlobalAppearances {
    [MXUIHelper customMoreOperationAppearance];
    [MXUIHelper customAlertControllerAppearance];
    [MXUIHelper customDialogViewControllerAppearance];
    [MXUIHelper customImagePickerAppearance];
    [MXUIHelper customEmotionViewAppearance];
    
    UISearchBar *searchBar = [UISearchBar appearance];
    searchBar.searchTextPositionAdjustment = UIOffsetMake(4, 0);
    
    QMUILabel *label = [QMUILabel appearance];
    label.highlightedBackgroundColor = TableViewCellSelectedBackgroundColor;
}

@end

@implementation MXCommonUI (ThemeColor)

static NSArray<UIColor *> *themeColors = nil;
+ (UIColor *)randomThemeColor {
    if (!themeColors) {
        themeColors = @[UIColorTheme1,
                        UIColorTheme2,
                        UIColorTheme3,
                        UIColorTheme4,
                        UIColorTheme5,
                        UIColorTheme6,
                        UIColorTheme7,
                        UIColorTheme8,
                        UIColorTheme9,
                        UIColorTheme10];
    }
    return themeColors[arc4random() % themeColors.count];
}

@end

@implementation MXCommonUI (Layer)

+ (CALayer *)generateSeparatorLayer {
    CALayer *layer = [CALayer layer];
    [layer qmui_removeDefaultAnimations];
    layer.backgroundColor = UIColorSeparator.CGColor;
    return layer;
}

@end

