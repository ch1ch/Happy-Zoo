//
//  GameSceneball.m
//  test1
//
//  Created by f on 11/4/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameSceneball.h"
#import "FirstScene.h"
#import "LoadingScene.h"
#import "GB2ShapeCache.h"
#define PTM_RATIO 32.0



@implementation GameSceneball

+(id) scene
{
    CCScene *scene=[CCScene node];
    GameSceneball *layer=[GameSceneball node];
    [scene addChild:layer];
    return scene;
    
}

-(id) init
{
    if((self=[super init]))
    {
        CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
         [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"balloon.mp3" loop:YES];
        
		self.isAccelerometerEnabled = YES;
        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        [CCTexture2D PVRImagesHavePremultipliedAlpha:YES];
        
        
        b2Vec2 gravity = b2Vec2(0.0f, 0.0f);
        _world =new b2World(gravity);
        
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"ballshelf-phys.plist"];
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"animal1-2.plist"];
       
        
        obstacle = [[NSMutableArray alloc] init];
        [self spawnball];
        [self drawshelf1]; [self drawshelf2]; [self drawshelf3];
        
        
        label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@" "] fontName:@"Marker Felt" fontSize:64];
        label1.position =  ccp(screenSize.width /2 ,screenSize.height/3 );
        [self addChild: label1 z:10];
        
        CCMenuItemImage *menum11 = [CCMenuItemImage itemFromNormalImage:@"gaming-pause.png" selectedImage:@"gaming-pause.png" disabledImage:@"gaming-pause.png" target:self selector:@selector(gamingmenu)];
        CCMenu *menu11 = [CCMenu menuWithItems: menum11, nil];
        menu11.position = CGPointMake(screenSize.width*0.9, screenSize.height*0.9);
        [self addChild: menu11 z:30];
        
        
        //背景，两张轮换
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"ballback_default.plist"];
        CCSpriteBatchNode* Spsbackgroup = [CCSprite spriteWithSpriteFrameName:@"List18_background1.png"];
        [Spsbackgroup setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
        [self addChild:Spsbackgroup z:0];
        CCAnimation *anibackgroup = [CCAnimation animation];
        for(unsigned int i = 1; i <3; i++)
        {
            NSString *naback = [NSString stringWithFormat:@"List18_background%d.png", i];
            [anibackgroup  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
        }
        [anibackgroup setDelayPerUnit:0.5f];
        id actback =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.5f], [CCAnimate  actionWithAnimation:anibackgroup], NULL]];
        [Spsbackgroup  runAction:actback];
        
        
        //女孩
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"ballgirl_default.plist"];
        Sgirl = [CCSprite spriteWithSpriteFrameName:@"ball-girl1.png"];
        float imageHeight=[Sgirl texture].contentSize.height;
        [Sgirl setPosition:ccp(screenSize.width*0.35 ,imageHeight*0.13)];
        [self addChild:Sgirl z:12 tag:12];
        CCAnimation *angirl = [CCAnimation animation];
        
        for(unsigned int i = 1; i < 3; i++)
        {
            NSString *nagirl = [NSString stringWithFormat:@"ball-girl%d.png", i];
            [angirl  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:nagirl]];
        }
        [angirl setDelayPerUnit:0.2f];
        id actgirl =[CCSequence actions:[CCDelayTime actionWithDuration:0.2f],[CCAnimate actionWithAnimation:angirl], NULL];
        [Sgirl  runAction:actgirl];
        girlvis=YES;
        
        [[SimpleAudioEngine sharedEngine]playEffect:@"wind.mp3" ];
        
        //草丛
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"grass_default.plist"];

        Sgrass = [CCSprite spriteWithSpriteFrameName:@"ball_grass_1.png"];
        [Sgrass setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.1)];
        [self addChild:Sgrass z:11];
        CCAnimation *angrass = [CCAnimation animation];
        for(unsigned int i = 1; i < 3; i++)
        {
            NSString *nagrass = [NSString stringWithFormat:@"ball_grass_%d.png", i];
            [angrass  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:nagrass]];
        }
        [angrass setDelayPerUnit:0.5f];
        id actgrass =[CCSequence actions:[CCDelayTime actionWithDuration:0.2f],[CCAnimate actionWithAnimation:angrass], NULL];
        [Sgrass  runAction:actgrass];
        
        
        
        //顶层
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"ball_top_default.plist"];
        Stop = [CCSprite spriteWithSpriteFrameName:@"ball_top_1.png"];
        [Stop setPosition:ccp(screenSize.width*0.5 ,screenSize.height*5.6)];
        [self addChild:Stop z:7];
        
        CCAnimation *antop = [CCAnimation animation];
        for(unsigned int i = 1; i < 3; i++)
        {
            NSString *natop = [NSString stringWithFormat:@"ball_top_%d.png", i];
            [antop  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:natop]];
        }
        
         [antop setDelayPerUnit:0.5f];
        id acttop =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:antop], NULL]];
        [Stop  runAction:acttop];
        
        //隐藏物品
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gameoverthings.plist"];
        game2treasure=[CCSprite spriteWithSpriteFrameName:@"treasure02.png"];
        [game2treasure setPosition:ccp(screenSize.width*0.81,screenSize.height*4.11)];
        [self addChild:game2treasure z:30 tag:501];
        [obstacle addObject:game2treasure];
        
        
        //动物
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"animal1.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"animal2.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"animal4.plist"];
         [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"animal5.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"animal6.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"animal7.plist"];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"animal8.plist"];
        [self drawanimal2];
        [self drawanimal3];
        [self drawanimal4];
         [self drawanimal5];
         [self drawanimal8];
        [self drawanimal9];
        [self drawanimal10];
        [self drawanimal11];
        [self drawanimal13]; [self drawanimal14]; [self drawanimal15];

              
        //小大象
        CCSpriteBatchNode *Animal0 = [CCSprite spriteWithSpriteFrameName:@"ball_animal1_1.png"];
        [Animal0 setPosition:ccp(screenSize.width*0.85,screenSize.height*0.25)];
        [self addChild:Animal0 z:10 tag:9];
        [obstacle addObject:Animal0];
        CCAnimation *ananmail0 = [CCAnimation animation];
        for(unsigned int i = 1; i < 3; i++)
        {
            NSString *naanmal0 = [NSString stringWithFormat:@"ball_animal1_%d.png", i];
            [ananmail0  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal0]];
        }
        
        [ananmail0 setDelayPerUnit:0.3f];
        id actanmal0 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail0], NULL]];
        [Animal0  runAction:actanmal0];
        
       
        //白鸟
        Animal1 = [CCSprite spriteWithSpriteFrameName:@"ball_animal3_1.png"];
        [Animal1 setPosition:ccp(screenSize.width*0.25 ,screenSize.height*0.83)];
        [self addChild:Animal1 z:15 tag:9];
        [obstacle addObject:Animal1];
        CCAnimation *ananmail1 = [CCAnimation animation];
        for(unsigned int i = 1; i < 3; i++)
        {
            NSString *naanmal1 = [NSString stringWithFormat:@"ball_animal3_%d.png", i];
            [ananmail1  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal1]];
        }
        
        [ananmail1 setDelayPerUnit:0.3f];
        id actanmal1 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail1], NULL]];
        [Animal1  runAction:actanmal1];
        
        
        
        
        
        
        // Enable debug draw
        _debugDraw =new GLESDebugDraw( PTM_RATIO );
        _world->SetDebugDraw(_debugDraw);
        uint32 flags =0;
        flags += b2Draw::   e_shapeBit;
        _debugDraw->SetFlags(flags);
        
        
        
        
        // Create contact listener
        _contactListener =new MyContactListener();
        _world->SetContactListener(_contactListener);
        
         [self schedule:@selector(tick:)];
        
        [self schedule:@selector(update:) interval:0.1f];
         [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    }
    return self;
}


-(void) draw
{
    glDisable(GL_TEXTURE_2D);
    //glDisableClientState(GL_COLOR_ARRAY);
    // glDisableClientState(GL_TEXTURE_COORD_ARRAY);
    
    _world->DrawDebugData();
    
    glEnable(GL_TEXTURE_2D);
    // glEnableClientState(GL_COLOR_ARRAY);
    //  glEnableClientState(GL_TEXTURE_COORD_ARRAY);
}




- (void)spawnball {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    ballself = [CCSprite spriteWithFile:@"balloon.png"];
    ballself.position = CGPointMake(500, screenSize.height*0.4);
    [self addChild:ballself z:10 tag:10];
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(ballself.position.x/PTM_RATIO, ballself.position.y/PTM_RATIO);
    bodyDef.userData = ballself;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"balloon";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [ballself setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
}


- (void)drawshelf1 {
    //CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    shelf1 = [CCSprite spriteWithFile:@"ball_shelf1.png"];
    shelf1.position = CGPointMake([shelf1 texture].contentSize.width*0.5,[shelf1 texture].contentSize.height*0.5);
    [self addChild:shelf1 z:10 tag:11];
    [obstacle addObject:shelf1];
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(shelf1.position.x/PTM_RATIO, shelf1.position.y/PTM_RATIO);
    bodyDef.userData = shelf1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"ball_shelf1";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [shelf1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
}

- (void)drawshelf2 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    CCSpriteBatchNode *shelf2 = [CCSprite spriteWithFile:@"ball_shelf2.png"];
    shelf2.position = CGPointMake(screenSize.width-[shelf2 texture].contentSize.width*0.5,[shelf2 texture].contentSize.height*0.5+1234);
    [self addChild:shelf2 z:10 tag:12];
    [obstacle addObject:shelf2];
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(shelf2.position.x/PTM_RATIO, shelf2.position.y/PTM_RATIO);
    bodyDef.userData = shelf2;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"ball_shelf2";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [shelf2 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
}

- (void)drawshelf3 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    
    CCSprite* shelf3 = [CCSprite spriteWithFile:@"ball_shelf3.png"];
    shelf3.position = CGPointMake(screenSize.width-[shelf3 texture].contentSize.width*0.5,[shelf3 texture].contentSize.height*0.5);
    [self addChild:shelf3 z:10 tag:13];
    [obstacle addObject:shelf3];
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(shelf1.position.x/PTM_RATIO, shelf1.position.y/PTM_RATIO);
    bodyDef.userData = shelf3;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"ball_shelf3";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [shelf3 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
}


//红鸟
- (void)drawanimal2 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
     
    Animal2 = [CCSprite spriteWithSpriteFrameName:@"ball_animal2_1.png"];
    [Animal2 setPosition:ccp(screenSize.width*0.75 ,screenSize.height*1.39)];
    [self addChild:Animal2 z:15 tag:41];
    [obstacle addObject:Animal2];
    

    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(Animal2.position.x/PTM_RATIO, Animal2.position.y/PTM_RATIO);
    bodyDef.userData = Animal2;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"ball_animal2_1";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [Animal1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    

    CCAnimation *ananmail1 = [CCAnimation animation];
    for(unsigned int i = 1; i < 17; i++)
    {
        NSString *naanmal1 = [NSString stringWithFormat:@"ball_animal2_%d.png", i];
        [ananmail1  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal1]];
    }
    
    [ananmail1 setDelayPerUnit:0.3f];
    id actanmal1 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail1], NULL]];
    [Animal2  runAction:actanmal1];
       
    
}

//猪
- (void)drawanimal3 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *Animal3 = [CCSprite spriteWithSpriteFrameName:@"ball_animal4_1.png"];
    [Animal3 setPosition:ccp(screenSize.width*0.16 ,screenSize.height*2.22)];
    [self addChild:Animal3 z:15 tag:42];
    [obstacle addObject:Animal3];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(Animal3.position.x/PTM_RATIO, Animal3.position.y/PTM_RATIO);
    bodyDef.userData = Animal3;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"ball_animal4_1";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [Animal1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    CCAnimation *ananmail1 = [CCAnimation animation];
    for(unsigned int i = 1; i < 8; i++)
    {
        NSString *naanmal1 = [NSString stringWithFormat:@"ball_animal4_%d.png", i];
        [ananmail1  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal1]];
    }
    
    [ananmail1 setDelayPerUnit:0.25f];
    id actanmal1 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail1], NULL]];
    [Animal3  runAction:actanmal1];
    
    
}

//鳄鱼
- (void)drawanimal4 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *Animal4 = [CCSprite spriteWithSpriteFrameName:@"ball_animal5_1.png"];
    [Animal4 setPosition:ccp(screenSize.width*0.17 ,screenSize.height*2.64)];
    [self addChild:Animal4 z:15 tag:44];
    [obstacle addObject:Animal4];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(Animal4.position.x/PTM_RATIO, Animal4.position.y/PTM_RATIO);
    bodyDef.userData = Animal4;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"ball_animal5_1";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [Animal4 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    CCAnimation *ananmail1 = [CCAnimation animation];
    for(unsigned int i = 1; i < 16; i++)
    {
        NSString *naanmal1 = [NSString stringWithFormat:@"ball_animal5_%d.png", i];
        [ananmail1  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal1]];
    }
    
    [ananmail1 setDelayPerUnit:0.25f];
    id actanmal1 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail1], NULL]];
    [Animal4  runAction:actanmal1];
    
    
}

//黑鸟
- (void)drawanimal5 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *Animal4 = [CCSprite spriteWithSpriteFrameName:@"ball_animal7_1.png"];
    [Animal4 setPosition:ccp(screenSize.width*0.15,screenSize.height*2.86)];
    [self addChild:Animal4 z:15 tag:45];
    [obstacle addObject:Animal4];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(Animal4.position.x/PTM_RATIO, Animal4.position.y/PTM_RATIO);
    bodyDef.userData = Animal4;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"ball_animal7_1";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [Animal4 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    CCAnimation *ananmail1 = [CCAnimation animation];
    for(unsigned int i = 1; i <9 ; i++)
    {
        NSString *naanmal1 = [NSString stringWithFormat:@"ball_animal7_%d.png", i];
        [ananmail1  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal1]];
    }
    
    [ananmail1 setDelayPerUnit:0.25f];
    id actanmal1 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail1], NULL]];
    [Animal4  runAction:actanmal1];
    
    
}

//大象
- (void)drawanimal8 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *Animal4 = [CCSprite spriteWithSpriteFrameName:@"ball_animal8_1.png"];
    [Animal4 setPosition:ccp(screenSize.width*0.76,screenSize.height*3.93)];
    [self addChild:Animal4 z:15 tag:48];
    [obstacle addObject:Animal4];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(Animal4.position.x/PTM_RATIO, Animal4.position.y/PTM_RATIO);
    bodyDef.userData = Animal4;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"ball_animal8_1";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [Animal4 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    CCAnimation *ananmail1 = [CCAnimation animation];
    for(unsigned int i = 1; i <8 ; i++)
    {
        NSString *naanmal1 = [NSString stringWithFormat:@"ball_animal8_%d.png", i];
        [ananmail1  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal1]];
    }
    
    [ananmail1 setDelayPerUnit:0.25f];
    id actanmal1 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail1], NULL]];
    [Animal4  runAction:actanmal1];
    
    
}

//章鱼
- (void)drawanimal9 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *Animal4 = [CCSprite spriteWithSpriteFrameName:@"ball_animal9_1.png"];
    [Animal4 setPosition:ccp(screenSize.width*0.8,screenSize.height*4.64)];
    [self addChild:Animal4 z:15 tag:49];
    [obstacle addObject:Animal4];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(Animal4.position.x/PTM_RATIO, Animal4.position.y/PTM_RATIO);
    bodyDef.userData = Animal4;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"ball_animal9_1";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [Animal4 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    CCAnimation *ananmail1 = [CCAnimation animation];
    for(unsigned int i = 1; i <10 ; i++)
    {
        NSString *naanmal1 = [NSString stringWithFormat:@"ball_animal9_%d.png", i];
        [ananmail1  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal1]];
    }
    
    [ananmail1 setDelayPerUnit:0.25f];
    id actanmal1 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail1], NULL]];
    [Animal4  runAction:actanmal1];
    
    
}


//长颈鹿
- (void)drawanimal10 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *Animal4 = [CCSprite spriteWithSpriteFrameName:@"ball_animal10_1.png"];
    [Animal4 setPosition:ccp(screenSize.width*(-0.01),screenSize.height*4.1)];
    [self addChild:Animal4 z:15 tag:50];
    [obstacle addObject:Animal4];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(Animal4.position.x/PTM_RATIO, Animal4.position.y/PTM_RATIO);
    bodyDef.userData = Animal4;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"ball_animal10_1";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [Animal4 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    CCAnimation *ananmail1 = [CCAnimation animation];
    for(unsigned int i = 1; i <18 ; i++)
    {
        NSString *naanmal1 = [NSString stringWithFormat:@"ball_animal10_%d.png", i];
        [ananmail1  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal1]];
    }
    
    [ananmail1 setDelayPerUnit:0.25f];
    id actanmal1 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail1], NULL]];
    [Animal4  runAction:actanmal1];
    
    
}



//鲸鱼
- (void)drawanimal11 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *Animal4 = [CCSprite spriteWithSpriteFrameName:@"ball_animal11_1.png"];
    [Animal4 setPosition:ccp(screenSize.width*(-0.8),screenSize.height*4.8)];
    [self addChild:Animal4 z:15 tag:260];
    [obstacle addObject:Animal4];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(Animal4.position.x/PTM_RATIO, Animal4.position.y/PTM_RATIO);
    bodyDef.userData = Animal4;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"ball_animal11_1";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [Animal4 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    CCAnimation *ananmail1 = [CCAnimation animation];
    for(unsigned int i = 1; i <3 ; i++)
    {
        NSString *naanmal1 = [NSString stringWithFormat:@"ball_animal11_%d.png", i];
        [ananmail1  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal1]];
    }
    
    [ananmail1 setDelayPerUnit:0.25f];
    id actanmal1 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail1], NULL]];
    [Animal4  runAction:actanmal1];
    
    
}


//羊驼
- (void)drawanimal13 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *Animal4 = [CCSprite spriteWithSpriteFrameName:@"ball_animal13_1.png"];
    [Animal4 setPosition:ccp(screenSize.width*0.7,screenSize.height*6.9)];
    [self addChild:Animal4 z:15 tag:53];
    [obstacle addObject:Animal4];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(Animal4.position.x/PTM_RATIO, Animal4.position.y/PTM_RATIO);
    bodyDef.userData = Animal4;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"ball_animal13_9";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [Animal4 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    CCAnimation *ananmail1 = [CCAnimation animation];
    for(unsigned int i = 1; i <15 ; i++)
    {
        NSString *naanmal1 = [NSString stringWithFormat:@"ball_animal13_%d.png", i];
        [ananmail1  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal1]];
    }
    
    [ananmail1 setDelayPerUnit:0.25f];
    id actanmal1 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail1], NULL]];
    [Animal4  runAction:actanmal1];
    
    
}

//豹子
- (void)drawanimal14 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *Animal4 = [CCSprite spriteWithSpriteFrameName:@"ball_animal14_1.png"];
    [Animal4 setPosition:ccp(screenSize.width*(-0.01),screenSize.height*7.7)];
    [self addChild:Animal4 z:15 tag:64];
    [obstacle addObject:Animal4];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(Animal4.position.x/PTM_RATIO, Animal4.position.y/PTM_RATIO);
    bodyDef.userData = Animal4;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"ball_animal14_1";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [Animal4 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    CCAnimation *ananmail1 = [CCAnimation animation];
    for(unsigned int i = 1; i <22 ; i++)
    {
        NSString *naanmal1 = [NSString stringWithFormat:@"ball_animal14_%d.png", i];
        [ananmail1  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal1]];
    }
    
    [ananmail1 setDelayPerUnit:0.25f];
    id actanmal1 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail1], NULL]];
    [Animal4  runAction:actanmal1];
    
    
}

//豹子
- (void)drawanimal15 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSprite *Animal4 = [CCSprite spriteWithSpriteFrameName:@"ball_animal15_1.png"];
    [Animal4 setPosition:ccp(screenSize.width*0.7,screenSize.height*8.0)];
    [self addChild:Animal4 z:15 tag:64];
    [obstacle addObject:Animal4];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(Animal4.position.x/PTM_RATIO, Animal4.position.y/PTM_RATIO);
    bodyDef.userData = Animal4;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"ball_animal15_1";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [Animal4 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
    CCAnimation *ananmail1 = [CCAnimation animation];
    for(unsigned int i = 1; i <20 ; i++)
    {
        NSString *naanmal1 = [NSString stringWithFormat:@"ball_animal15_%d.png", i];
        [ananmail1  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naanmal1]];
    }
    
    [ananmail1 setDelayPerUnit:0.25f];
    id actanmal1 =[CCRepeatForever actionWithAction: [CCSequence actions:[CCDelayTime actionWithDuration:0.1f], [CCAnimate  actionWithAnimation:ananmail1], NULL]];
    [Animal4  runAction:actanmal1];
    
    
}


-(void) dealloc
{
    CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    delete _world;
    delete _debugDraw;
    delete _contactListener;
    obstacle=nil;
    
    [super dealloc];
}

-(void) accelerometer:(UIAccelerometer *)accelerometer didAccelerate:(UIAcceleration *)acceleration
{
    
    
    // this controls how quickly the velocity decelerates (lower = quicker to change direction)
	float deceleration = 0.6f;
	// this determines how sensitive the accelerometer reacts (higher = more sensitive)
	float sensitivity = 7.0f;
	// how fast the velocity can be at most
	float maxVelocity = 240;
    
	// adjust velocity based on current accelerometer acceleration
	playerVelocity.y = playerVelocity.y * deceleration + acceleration.y * sensitivity;
	
	// we must limit the maximum velocity of the player sprite, in both directions (positive & negative values)
	if (playerVelocity.y > maxVelocity)
	{
		playerVelocity.y = maxVelocity;
	}
	else if (playerVelocity.y < -maxVelocity)
	{
		playerVelocity.y = -maxVelocity;
    }
    
}

-(void) update:(ccTime)delta
{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    gametime++;
    NSLog(@"game time is %d",gametime);
    
    //隐藏物品判断
    if (game2thing==1) {

        game2treasure.visible=NO;
        [[SimpleAudioEngine sharedEngine]playEffect:@"foundthing.mp3"];
        game2thing=2;
        
        game2treasures=[CCSprite spriteWithSpriteFrameName:@"Game-treasure2.png"];
        [game2treasures setPosition:ccp(screenSize.width*0.12,screenSize.height*0.14)];
        [self addChild:game2treasures z:35];
        
    }
    if (game2thing==2) {
        wait2star++;
        if (wait2star>20) {
            
        
        CGPoint temp=game2treasures.position;
        temp.x=temp.x-3;
        temp.y=temp.y-3;
        game2treasures.position=temp;
        }
    }
    
    //鲸鱼移动
    CCSprite *whale=(CCSprite *)[self getChildByTag:260];
    NSLog(@"ele~~x= %f   y=%f",whale.position.x,whale.position.y);
    CGPoint whaletemp=whale.position;
    if (whaletemp.y<150) {
        if (whaletemp.y<-700)
        {
            whaletemp.x=whaletemp.x+15;
        }else
        {
            if (whaletemp.x<-400)
            {
                whaletemp.x=whaletemp.x+5;
            }
        }
    whale.position=whaletemp;
    }
    
    //女孩显示
    if(girlvis)
    {
        CGPoint pos2=Sgirl.position;
        CGPoint pos3=Sgrass.position;
        pos2.y-=10;
        pos3.y-=10;
        if(pos2.y<-350)
        {
            girlvis=NO;
        }
        Sgirl.position=pos2;
        Sgrass.position=pos3;
        
    }
    
    //判定是否到达顶层的气球
    if (Stop.position.y<=(screenSize.height+10))
    {
        if (ballself.position.y<screenSize.height*0.71)
        {
            //气球位置变化
            CGPoint pos4=ballself.position;
            pos4.y+=10;
            ballself.position=pos4;
            
        }else
        {
            label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Win! "] fontName:@"Marker Felt" fontSize:64];
            label1.position =  ccp(screenSize.width /2 ,screenSize.height/3 );
            //[self addChild: label1 z:50];
            if (gamewin==0) {

            id acfover = [CCCallFunc actionWithTarget:self selector:@selector(gampause)];
            
            [self Gameovers];
            gamewin=1;
            }
        }
        
    }else
    {
        CGPoint pos4=Stop.position;
        pos4.y-=10;
        Stop.position=pos4;
       // CCLOG(@" stop.postion.y=%f",pos4.y);
    }
    
    
    //所有元素位置更新
    if (gameover==0){
        

   // for (int num=0; num<14; num++) {
    for(CCSprite *sprite in obstacle){
       // CCSprite *sprite=[obstacle objectAtIndex:num];
        //if (sprite.position.y+[sprite texture].contentSize.height>-50) {
           [self runobsMoveSequence:sprite];
       // }
    
    }
            }
    
    
    CGPoint pos = ballself.position;
	pos.x -= playerVelocity.y;
	// The Player should also be stopped from going outside the screen
	
	float imageWidthHalved = [ballself texture].contentSize.width * 0.5f;
	float leftBorderLimit = imageWidthHalved;
	float rightBorderLimit = screenSize.width;
    
	if (pos.x < leftBorderLimit)
	{
		pos.x = leftBorderLimit;
        
		// also set velocity to zero because the player is still accelerating towards the border
		playerVelocity = CGPointZero;
	}
	else if (pos.x > rightBorderLimit)
	{
		pos.x = rightBorderLimit;
        
		// also set velocity to zero because the player is still accelerating towards the border
		playerVelocity = CGPointZero;
	}
    
	ballself.position = pos;
    
    
    
}





- (void)tick:(ccTime)dt {
    
    // Updates the physics simulation for 10 iterations for velocity/position
    _world->Step(dt, 10, 10);
    
    // Loop through all of the Box2D bodies in our Box2D world..
    for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext()) {
        
        // See if there's any user data attached to the Box2D body
        // There should be, since we set it in addBoxBodyForSprite
        if (b->GetUserData() != NULL) {
            
            // We know that the user data is a sprite since we set
            // it that way, so cast it...
            CCSprite *sprite = (CCSprite *)b->GetUserData();
            
            // Convert the Cocos2D position/rotation of the sprite to the Box2D position/rotation
            b2Vec2 b2Position = b2Vec2(sprite.position.x/PTM_RATIO,
                                       sprite.position.y/PTM_RATIO);
            float32 b2Angle = -1 * CC_DEGREES_TO_RADIANS(sprite.rotation);
            
            // Update the Box2D position/rotation to match the Cocos2D position/rotation
            b->SetTransform(b2Position, b2Angle);
        }
    }
     //[label1 setString:[NSString stringWithFormat:@"0 and  0"]];
    // Loop through all of the box2d bodies that are currently colliding, that we have
    // gathered with our custom contact listener...
    std::vector<b2Body *>toDestroy;
    std::vector<MyContact>::iterator pos;
    for(pos = _contactListener->_contacts.begin(); pos != _contactListener->_contacts.end(); ++pos) {
        MyContact contact = *pos;
        
        // Get the box2d bodies for each object
        b2Body *bodyA = contact.fixtureA->GetBody();
        b2Body *bodyB = contact.fixtureB->GetBody();
        
        
        if (bodyA->GetUserData() != NULL && bodyB->GetUserData() != NULL)
        {
            CCSprite *spriteA = (CCSprite *) bodyA->GetUserData();
            CCSprite *spriteB = (CCSprite *) bodyB->GetUserData();
           // NSLog(@"%d  and   %d   zhuangjila~~",spriteA.tag,spriteB.tag);
            


                if(spriteA.tag==10||spriteB.tag==10)
                {
                    if((spriteA.position.y+[spriteA texture].contentSize.height>-50) && (spriteB.position.y+[spriteB texture].contentSize.height>-50) )
                    {
                        
               
            
                    NSLog(@"%d  and   %d   zhuangjila~~",spriteA.tag,spriteB.tag);
                        if (gameover==0) {
                            
                           // [label1 setString:[NSString stringWithFormat:@"%d  and  %d",spriteA.tag,spriteB.tag]];
                                              [self gamefalse];
                        }

                        
 
                    }


            }
        }
    }
    
   
}

-(void)gamefalse{
    gameover=1;
    
    if (bangbang==0) {
        [[SimpleAudioEngine sharedEngine]playEffect:@"peng.mp3" ];

    }
    bangbang=1;
    

    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    ballself.visible=NO;

    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"ball_bang.plist"];
    CCSpriteBatchNode* Spsbackgroup = [CCSprite spriteWithSpriteFrameName:@"ball_bang1.png"];
    CGPoint tempp=ballself.position;
    tempp.y=tempp.y+150;
    [Spsbackgroup setPosition:tempp];
    [self addChild:Spsbackgroup z:30];
    CCAnimation *anibackgroup = [CCAnimation animation];
    for(unsigned int i = 1; i <6; i++)
    {
        NSString *naback = [NSString stringWithFormat:@"ball_bang%d.png", i];
        [anibackgroup  addSpriteFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:naback]];
    }
    [anibackgroup setDelayPerUnit:0.3f];
    
    id aclongtime = [CCCallFunc actionWithTarget:self selector:@selector(simLongLoadingTime)];
    id acover = [CCCallFunc actionWithTarget:self selector:@selector(Gameovers)];
    [Spsbackgroup runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.3f],[CCAnimate  actionWithAnimation:anibackgroup],[CCDelayTime actionWithDuration:1.1f],aclongtime,acover,NULL]];


    
       
    
}

-(void) runobsMoveSequence:(CCSprite*)spider
{
    
	CGPoint belowScreenPosition = CGPointMake(spider.position.x,spider.position.y-30);
    //CCLOG(@" --- %d ---- %f -----", belowScreenPosition.x,belowScreenPosition.y);
	CCMoveTo* move = [CCMoveTo actionWithDuration:0.1f position:belowScreenPosition];
    
	CCSequence* sequence = [CCSequence actions:move,nil];
	[spider runAction:sequence];
  
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];
    return TRUE;
}


- (void)selectSpriteForTouch:(CGPoint)touchLocation
{
    
    
    if (CGRectContainsPoint(game2treasure.boundingBox, touchLocation))
    {
        NSLog(@"faxianla1");
        game2thing=1;
        //[game1treasure removeFromParentAndCleanup:YES];
        // [self removeChild:game1treasure cleanup:YES];
        
    }
}

-(void) simLongLoadingTime
{
	// Simulating a long loading time by doing some useless calculation a large number of times.
	double a = 122, b = 243;
	for (unsigned int i = 0; i < 60000000; i++)
	{
		a = a / b;
	}
}

-(void)Gameovers{
    //[self simLongLoadingTime];
    CGSize screenSize=[[CCDirector sharedDirector] winSize];
    if (gametime>300) {
        game2level=3;
          [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
         [[SimpleAudioEngine sharedEngine]playEffect:@"start3.mp3" ];

        CCSprite *gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end4.png"];
        
        [gamesprite setPosition:ccp(screenSize.width*0.5,screenSize.height*0.5)];
        [self addChild:gamesprite z:50 tag:501];
    
        
    }else if (gametime>200){
        game2level=2;
          [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
        [[SimpleAudioEngine sharedEngine]playEffect:@"start2.mp3" ];
        
        CCSprite *gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end3.png"];
        
        [gamesprite setPosition:ccp(screenSize.width*0.5,screenSize.height*0.5)];
        [self addChild:gamesprite z:50 tag:501];
        
    }else if(gametime>110){
        game2level=1;
          [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
         [[SimpleAudioEngine sharedEngine]playEffect:@"start1.mp3" ];

        CCSprite *gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end2.png"];
        [gamesprite setPosition:ccp(screenSize.width*0.5,screenSize.height*0.5)];
        [self addChild:gamesprite z:50 tag:501];

    }else{
        CCSprite *gamesprite=[CCSprite spriteWithSpriteFrameName:@"game-end1.png"];
          [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
         [[SimpleAudioEngine sharedEngine]playEffect:@"start0.mp3" ];
        [gamesprite setPosition:ccp(screenSize.width*0.5,screenSize.height*0.5)];
        [self addChild:gamesprite z:50 tag:501];
    }
    
    //[[CCDirector sharedDirector] pause];
    
    CCMenuItemImage *menum2 = [CCMenuItemImage itemFromNormalImage:@"gaming-list2.png" selectedImage:@"gaming-list2-1.png" disabledImage:@"gaming-list2.png" target:self selector:@selector(gomenu2)];
    menu2 = [CCMenu menuWithItems: menum2, nil];
    menu2.position =  CGPointMake(screenSize.width*0.31, screenSize.height*0.48);
    [self addChild: menu2 z:55 tag:122];
    
    CCMenuItemImage *menum5 = [CCMenuItemImage itemFromNormalImage:@"gaming-list5.png" selectedImage:@"gaming-list5-1.png" disabledImage:@"gaming-list5.png" target:self selector:@selector(gomenu5)];
    menu5 = [CCMenu menuWithItems: menum5, nil];
    menu5.position =  CGPointMake(screenSize.width*0.39, screenSize.height*0.33);
    [self addChild: menu5 z:55 tag:125];
    
    CCMenuItemImage *menum7 = [CCMenuItemImage itemFromNormalImage:@"gaming-list7.png" selectedImage:@"gaming-list7-1.png" disabledImage:@"gaming-list7.png" target:self selector:@selector(gomenu7)];
    menu7 = [CCMenu menuWithItems: menum7, nil];
    menu7.position =  CGPointMake(screenSize.width*0.51, screenSize.height*0.26);
    [self addChild: menu7 z:55 tag:125];
    
    
    //CCTransitionFade *tranScene=[CCTransitionFade transitionWithDuration:1 scene:[GameOverScene scene]];
    //[[CCDirector sharedDirector] replaceScene:tranScene];
    
}

-(void) gamingmenu
{
    [[CCDirector sharedDirector] pause];
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    backgroundmenu = [CCSprite spriteWithFile:@"gaming-listback.png"];
    backgroundmenu.position = CGPointMake(screenSize.width*0.78,screenSize.height*0.7);
    [self addChild:backgroundmenu z:35 tag:120];
    
    CCMenuItemImage *menum1 = [CCMenuItemImage itemFromNormalImage:@"gaming-list1.png" selectedImage:@"gaming-list1-1.png" disabledImage:@"gaming-list1.png" target:self selector:@selector(gomenu1)];
    menu1 = [CCMenu menuWithItems: menum1, nil];
    menu1.position = CGPointMake(screenSize.width*0.9, screenSize.height*0.86);
    [self addChild: menu1 z:40 tag:121];
    
    
    CCMenuItemImage *menum2 = [CCMenuItemImage itemFromNormalImage:@"gaming-list2.png" selectedImage:@"gaming-list2-1.png" disabledImage:@"gaming-list2.png" target:self selector:@selector(gomenu2)];
    menu2 = [CCMenu menuWithItems: menum2, nil];
    menu2.position =  CGPointMake(screenSize.width*0.68, screenSize.height*0.91);
    
    [self addChild: menu2 z:40 tag:122];
    
    CCMenuItemImage *menum3 = [CCMenuItemImage itemFromNormalImage:@"gaming-list3.png" selectedImage:@"gaming-list3-1.png" disabledImage:@"gaming-list3.png" target:self selector:@selector(gomenu3)];
    menu3 = [CCMenu menuWithItems: menum3, nil];
    menu3.position =  CGPointMake(screenSize.width*0.81, screenSize.height*0.62);
    
    [self addChild: menu3 z:40 tag:123];
    
    CCMenuItemImage *menum4 = [CCMenuItemImage itemFromNormalImage:@"gaming-list4.png" selectedImage:@"gaming-list4-1.png" disabledImage:@"gaming-list4.png" target:self selector:@selector(gomenu4)];
    menu4 = [CCMenu menuWithItems: menum4, nil];
    menu4.position =  CGPointMake(screenSize.width*0.93, screenSize.height*0.58);
    [self addChild: menu4 z:40 tag:124];
    
    CCMenuItemImage *menum5 = [CCMenuItemImage itemFromNormalImage:@"gaming-list5.png" selectedImage:@"gaming-list5-1.png" disabledImage:@"gaming-list5.png" target:self selector:@selector(gomenu5)];
    menu5 = [CCMenu menuWithItems: menum5, nil];
    menu5.position =  CGPointMake(screenSize.width*0.72, screenSize.height*0.74);
    [self addChild: menu5 z:40 tag:125];
    
    
    
}

-(void) gomenu1{
    //  [self removeAnimationByName: ];
    // [[CCAnimationCache sharedAnimationCache] removeAnimationByName:@"gamefish"];
    //   CCNode *node=[self getchildbytag:120];
    //  CCSprite *spriteName=(sprite*) node;
    [self removeChildByTag:120 cleanup:YES];
    [self removeChildByTag:121 cleanup:YES];
    [self removeChildByTag:122 cleanup:YES];
    [self removeChildByTag:123 cleanup:YES];
    [self removeChildByTag:124 cleanup:YES];
    [self removeChildByTag:125 cleanup:YES];
    [[CCDirector sharedDirector] resume];
    
    
    
}


-(void) backmenu
{
    [[CCDirector sharedDirector] resume];
    [[CCDirector sharedDirector] replaceScene:[FirstScene scene]];
}


-(void) gampause
{
    [[CCDirector sharedDirector] pause];
}

-(void) gomenu2
{
     [[SimpleAudioEngine sharedEngine]playEffect:@"replay.mp3"];
    [[CCDirector sharedDirector] resume];
     CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetScene2Scene];
      [[CCDirector sharedDirector] replaceScene:newScene];
    
}


-(void)gomenu4{
    isPlaying=[[SimpleAudioEngine sharedEngine]isBackgroundMusicPlaying];
    if (isPlaying) {
        [[SimpleAudioEngine sharedEngine]stopBackgroundMusic];
    }else{
        [[SimpleAudioEngine sharedEngine]playBackgroundMusic:@"balloon.mp3" loop:YES];
    }
    
}

-(void) gomenu5
{
    [[CCDirector sharedDirector] resume];
     CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetSceneHome];
     [[CCDirector sharedDirector] replaceScene:newScene];
    
}
-(void) gomenu7{
    [[CCDirector sharedDirector] resume];
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetSceneFirstScene];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}


@end
