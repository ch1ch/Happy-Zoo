//
//  GamepadMenu.h
//  Happy Zoo
//
//  Created by f on 4/19/13.
//
//

#import "CCLayer.h"
#import "SimpleAudioEngine.h"

@interface GamepadMenu : CCLayer{
    CCMenu *menu1;
    CCMenu *menu2;
    CCMenu *menu3;
    CCMenu *menu4;
    CCMenu *menu5;
    CCSprite * backgroundmenu;
    CGSize screenSize;
    BOOL isPlaying;
}

@end
