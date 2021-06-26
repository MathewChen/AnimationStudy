//
//  UndoManagerHelper.h
//  AnimationStudy
//
//  Created by mingxing on 2021/4/9.
//  Copyright © 2021 Star. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseItem.h"
#import "UndoManagerModel.h"

@interface UndoManagerHelper : NSObject

- (void)itemBeforAction:(BaseItem*)baseItem;

- (void)itemAction:(BaseItem*)baseItem UndoType:(UndoType)undoType;

- (void)itemAfterAction:(BaseItem*)baseItem;

@end


