//
//  FirstsceList.h
//  test1
//
//  Created by f on 11/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
extern int game1level;
extern int game1thing;
extern int game2level;
extern int game2thing;
extern int game3level;
extern int game3thing;
extern int game4level;
extern int game4thing;

@interface FirstsceList : CCLayer {
   /// CGPoint ListLayerPosition;
	    CCSprite * background;
    
}
-(void) gomenu1;
-(void) gomenu2;


@end
