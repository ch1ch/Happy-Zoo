//
//  GamepadCenter.m
//  Happy Zoo
//
//  Created by f on 4/19/13.
//
//

#import "GamepadCenter.h"
#import "GB2ShapeCache.h"
#import "LoadingScene.h"
#import "GameScenepad.h"


#define PTM_RATIO 32.0


@implementation GamepadCenter



-(id)init
{
    if ((self =[super init]))
    {

        CGSize screenSize = [[CCDirector sharedDirector] winSize];
        phystay=0;
        thing1key=301;
        
        if (padbacknumber==0) {
            padbacknumber=1;
        }
        
        self.anchorPoint = ccp(screenSize.width*0.5 ,screenSize.height*0.5);
   
        allanmial = [[CCArray alloc] init];
        allthings=[[CCArray alloc]init];
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"padpic-1.plist"];
         [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"padback-2.plist"];
         [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"padback-3.plist"];
        [[GB2ShapeCache sharedShapeCache] addShapesWithFile:@"pad-set.plist"];
        
        CCSpriteBatchNode* backgroup = [CCSprite spriteWithSpriteFrameName:@"myzoo_background1.png"];
        [backgroup setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
        [self addChild:backgroup z:20];


        [self setupPhysicsWorld];
   
        
        // Create edges around the entire screen
        b2BodyDef groundBodyDef;
        groundBodyDef.position.Set(0,0);
        b2Body *groundBody = _world->CreateBody(&groundBodyDef);
        b2EdgeShape groundBox;
        
        
        //bottom
        groundBox.Set(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO));
        groundBody->CreateFixture(&groundBox,0);
        
        // top
        groundBox.Set(b2Vec2(0,screenSize.height/PTM_RATIO), b2Vec2(screenSize.width/PTM_RATIO,screenSize.height/PTM_RATIO));
        groundBody->CreateFixture(&groundBox,0);
        
        // left
        groundBox.Set(b2Vec2(130,screenSize.height/PTM_RATIO), b2Vec2(130,0));
        groundBody->CreateFixture(&groundBox,0);
        
        // right
        groundBox.Set(b2Vec2((screenSize.width-130)/PTM_RATIO,screenSize.height/PTM_RATIO), b2Vec2((screenSize.width-130)/PTM_RATIO,0));
        groundBody->CreateFixture(&groundBox,0);
        
        //隐藏物品
        if (padbacknumber==1) {
            
        
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"gameoverthings.plist"];
        game4treasure=[CCSprite spriteWithSpriteFrameName:@"treasure04.png"];
        [game4treasure setPosition:ccp(screenSize.width*0.86,screenSize.height*0.2)];
        [self addChild:game4treasure z:30 tag:501];
        }

        
        
        [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
        
       
        [self drawback:1];
        [self drawrightmenu];
        [self drawlist];
     
    }
    

    // Create contact listener
    _contactListener =new MyContactListener();
    _world->SetContactListener(_contactListener);
    
    
    //[self schedule:@selector(update:) interval:0.1f];
    
    [self schedule:@selector(tick:)interval:0.1f];
    [self schedule:@selector(update:) interval:0.1f];
    
    
    return self;
    
}



-(void) setupPhysicsWorld {
    
    
    b2Vec2 gravity = b2Vec2(0.0f, -3.0f);
    _world = new b2World(gravity);
    

     
     _debugDraw = new GLESDebugDraw(PTM_RATIO);
     _world->SetDebugDraw(_debugDraw);
     uint32 flags = 0;
     flags += b2Draw::   e_shapeBit;
     _debugDraw->SetFlags(flags);
     

    
    _contactListener =new MyContactListener();
    _world->SetContactListener(_contactListener);
}


- (void)tick:(ccTime) dt {
   // CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    //世界物体位置更新
    _world->Step(dt, 8, 3);
    for(b2Body *b = _world->GetBodyList(); b; b=b->GetNext())
    {
        if (b->GetUserData() != NULL)
        {
            CCSprite *ballData = (CCSprite *)b->GetUserData();
            CCSprite *tempspite=(CCSprite *)[self getChildByTag:ballData.tag];
            
            if (phystay==0) {
              // b2Vec2  gravity =b2Vec2(0.0f,0.0f);

               // _world->SetGravity(gravity);

               // b->SetTransform(b2Vec2(tempspite.position.x/PTM_RATIO,tempspite.position.y/PTM_RATIO), 0);
               // tempspite.position=ballData.position;
                //tempspite.rotation=ballData.rotation;
                //ballData.rotation =-1* CC_RADIANS_TO_DEGREES(b->GetAngle());
                
                //float angletemp=b->GetAngle();
                b->SetTransform(b2Vec2(tempspite.position.x/PTM_RATIO,tempspite.position.y/PTM_RATIO), 0);
                
                // ballData.position =CGPointMake(b->GetPosition().x*PTM_RATIO, b->GetPosition().y*PTM_RATIO);
                
            }else{
                b2Vec2  gravity =b2Vec2(0.0f,-3.0f);
                
               _world->SetGravity(gravity);
                //b->SetTransform(b2Vec2(tempspite.position.x/PTM_RATIO,tempspite.position.y/PTM_RATIO), 0);
                ballData.position =CGPointMake(b->GetPosition().x*PTM_RATIO, b->GetPosition().y*PTM_RATIO);
            }
            

            ballData.rotation =-1* CC_RADIANS_TO_DEGREES(b->GetAngle());
                         
        }
           
    }
      
}

-(void)update:(ccTime) dt {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    if (game4thing==1) {
        
        game4treasure.visible=NO;
        [[SimpleAudioEngine sharedEngine]playEffect:@"foundthing.mp3"];
        game4thing=2;
        
        game4treasures=[CCSprite spriteWithSpriteFrameName:@"Game-treasure4.png"];
        [game4treasures setPosition:ccp(screenSize.width*0.12,screenSize.height*0.14)];
        [self addChild:game4treasures z:55];
        
    }
    if (game4thing==2) {
        waittimetrea++;
        if (waittimetrea>20) {
            CGPoint temp=game4treasures.position;
            temp.x=temp.x-2;
            temp.y=temp.y-2;
            game4treasures.position=temp;
        }
    }


        
    
}

-(void)drawgameover{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"You Win! "] fontName:@"Marker Felt" fontSize:64];
    label1.position =  ccp(screenSize.width*0.5 ,screenSize.height*0.5 );
    [label1 setString:[NSString stringWithFormat:@"Game Win!"]];
    [self addChild: label1];
    [[CCDirector sharedDirector] pause];
}

-(void) draw
{
    glDisable(GL_TEXTURE_2D);
    _world->DrawDebugData();
    
    glEnable(GL_TEXTURE_2D);
    
}


- (void)drawback :(int )num  {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    NSString *backstring=[ NSString  stringWithFormat:@"myzoo_picture%d.png",padbacknumber];
    NSString *backstringname=[ NSString  stringWithFormat:@"myzoo_picture%d",padbacknumber];

    
    CCSprite *gameplayback = [CCSprite spriteWithSpriteFrameName:backstring];
    [gameplayback setPosition:ccp(screenSize.width*0.0 ,screenSize.height*0.0)];
    [self addChild:gameplayback z:10 tag:101];
    
    CCSpriteBatchNode* backgroup2 = [CCSprite spriteWithSpriteFrameName:@"myzoo_background2.png"];
    [backgroup2 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:backgroup2 z:35];
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_staticBody;
    bodyDef.position.Set(gameplayback.position.x/PTM_RATIO, gameplayback.position.y/PTM_RATIO);
    bodyDef.userData = gameplayback;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = backstringname;
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [gameplayback setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
}
-(void)drawrightmenu{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    CCMenuItemImage *menu1 = [CCMenuItemImage itemFromNormalImage:@"myzoo_sign_stay.png" selectedImage:@"myzoo_sign_stay2.png" disabledImage:@"myzoo_sign_stay.png" target:self selector:@selector(menu1)];
    CCMenu *menum1 = [CCMenu menuWithItems: menu1, nil];
    menum1.position =  CGPointMake(screenSize.width*0.97, screenSize.height*0.4);
    [self addChild: menum1 z:40];
    
    CCMenuItemImage *menu2 = [CCMenuItemImage itemFromNormalImage:@"myzoo_sign_restarting1.png" selectedImage:@"myzoo_sign_restarting2.png" disabledImage:@"myzoo_sign_restarting1.png" target:self selector:@selector(menureset)];
    CCMenu *menum2 = [CCMenu menuWithItems: menu2, nil];
    menum2.position =  CGPointMake(screenSize.width*0.97, screenSize.height*0.3);
    [self addChild: menum2 z:40];
    
    CCMenuItemImage *menu3 = [CCMenuItemImage itemFromNormalImage:@"myzoo_photo1.png" selectedImage:@"myzoo_photo2.png" disabledImage:@"myzoo_photo1.png" target:self selector:@selector(menuphoto)];
    CCMenu *menum3 = [CCMenu menuWithItems: menu3, nil];
    menum3.position =  CGPointMake(screenSize.width*0.97, screenSize.height*0.2);
    [self addChild: menum3 z:40];
    
    CCMenuItemImage *menulistleft = [CCMenuItemImage itemFromNormalImage:@"myzoo_sign2_back1.png" selectedImage:@"myzoo_sign2_back2.png" disabledImage:@"myzoo_sign2_back1.png" target:self selector:@selector(menulistturnleft)];
    CCMenu *menulistleftm = [CCMenu menuWithItems: menulistleft, nil];
    menulistleftm.position =  CGPointMake(screenSize.width*0.05, screenSize.height*0.07);
    [self addChild: menulistleftm z:40];
    
    CCMenuItemImage *menulistright = [CCMenuItemImage itemFromNormalImage:@"myzoo_sign2_next1.png" selectedImage:@"myzoo_sign2_next2.png" disabledImage:@"myzoo_sign2_next1.png" target:self selector:@selector(menulistturnright)];
    CCMenu *menulistrightm = [CCMenu menuWithItems: menulistright, nil];
    menulistrightm.position =  CGPointMake(screenSize.width*0.95, screenSize.height*0.07);
    [self addChild: menulistrightm z:40];
    
    CCMenuItemImage *menubackleft = [CCMenuItemImage itemFromNormalImage:@"myzoo_sign_back1.png" selectedImage:@"myzoo_sign_back2.png" disabledImage:@"myzoo_sign_back1.png" target:self selector:@selector(menubackgrleft)];
    CCMenu *menubackleftm = [CCMenu menuWithItems: menubackleft, nil];
    menubackleftm.position =  CGPointMake(screenSize.width*0.05, screenSize.height*0.5);
    [self addChild: menubackleftm z:40];
    
    CCMenuItemImage *menubackright = [CCMenuItemImage itemFromNormalImage:@"myzoo_sign_next1.png" selectedImage:@"myzoo_sign_next2.png" disabledImage:@"myzoo_sign_next1.png" target:self selector:@selector(menubackgrright)];
    CCMenu *menubackrightm = [CCMenu menuWithItems: menubackright, nil];
    menubackrightm.position =  CGPointMake(screenSize.width*0.95, screenSize.height*0.5);
    [self addChild: menubackrightm z:40];
}


-(void)drawlist{
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    list1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list1.png"];
    [list1 setPosition:ccp(screenSize.width*0.16 ,screenSize.height*0.07)];
    [self addChild:list1 z:25 tag:701];
    [allanmial addObject:list1];
    

    list2 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list2.png"];
    [list2 setPosition:ccp(screenSize.width*0.29,screenSize.height*0.07)];
    [self addChild:list2 z:25 tag:702];
    [allanmial addObject:list2];
    
    list3 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list3.png"];
    [list3 setPosition:ccp(screenSize.width*0.41,screenSize.height*0.07)];
    [self addChild:list3 z:25 tag:703];
    [allanmial addObject:list3];
    
    list4 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list4.png"];
    [list4 setPosition:ccp(screenSize.width*0.58,screenSize.height*0.07)];
    [self addChild:list4 z:25 tag:704];
    [allanmial addObject:list4];
    
    list5 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list5.png"];
    [list5 setPosition:ccp(screenSize.width*0.72,screenSize.height*0.07)];
    [self addChild:list5 z:25 tag:705];
    [allanmial addObject:list5];
    
    list6 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list6.png"];
    [list6 setPosition:ccp(screenSize.width*0.85,screenSize.height*0.07)];
    [self addChild:list6 z:25 tag:706];
    [allanmial addObject:list6];
    
    list7 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list7.png"];
    [list7 setPosition:ccp(screenSize.width*1.13,screenSize.height*0.07)];
    [self addChild:list7 z:25 tag:707];
    [allanmial addObject:list7];
    
    list8 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list8.png"];
    [list8 setPosition:ccp(screenSize.width*1.27,screenSize.height*0.07)];
    [self addChild:list8 z:25 tag:708];
    [allanmial addObject:list8];
    
    list9 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list9.png"];
    [list9 setPosition:ccp(screenSize.width*1.46,screenSize.height*0.07)];
    [self addChild:list9 z:25 tag:709];
    [allanmial addObject:list9];
    
    list10 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list10.png"];
    [list10 setPosition:ccp(screenSize.width*1.62,screenSize.height*0.07)];
    [self addChild:list10 z:25 tag:710];
    [allanmial addObject:list10];
    
    list11 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list11.png"];
    [list11 setPosition:ccp(screenSize.width*1.73,screenSize.height*0.07)];
    [self addChild:list11 z:25 tag:711];
    [allanmial addObject:list11];
    
    list12 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list12.png"];
    [list12 setPosition:ccp(screenSize.width*1.85,screenSize.height*0.07)];
    [self addChild:list12 z:25 tag:712];
    [allanmial addObject:list12];
    
    list13 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list13.png"];
    [list13 setPosition:ccp(screenSize.width*2.14,screenSize.height*0.07)];
    [self addChild:list13 z:25 tag:713];
    [allanmial addObject:list13];
    
    list14 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list14.png"];
    [list14 setPosition:ccp(screenSize.width*2.28,screenSize.height*0.07)];
    [self addChild:list14 z:25 tag:714];
    [allanmial addObject:list14];
    
    list15 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list15.png"];
    [list15 setPosition:ccp(screenSize.width*2.42,screenSize.height*0.07)];
    [self addChild:list15 z:25 tag:715];
    [allanmial addObject:list15];
  
    list16 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list16.png"];
    [list16 setPosition:ccp(screenSize.width*2.53,screenSize.height*0.07)];
    [self addChild:list16 z:25 tag:716];
    [allanmial addObject:list16];
    
    list17 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list17.png"];
    [list17 setPosition:ccp(screenSize.width*2.64,screenSize.height*0.07)];
    [self addChild:list17 z:25 tag:717];
    [allanmial addObject:list17];
  
    list18 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list18.png"];
    [list18 setPosition:ccp(screenSize.width*2.75,screenSize.height*0.07)];
    [self addChild:list18 z:25 tag:718];
    [allanmial addObject:list18];
    
    list19 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list19.png"];
    [list19 setPosition:ccp(screenSize.width*2.85,screenSize.height*0.07)];
    [self addChild:list19 z:25 tag:719];
    [allanmial addObject:list19];
    
    list20 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list20.png"];
    [list20 setPosition:ccp(screenSize.width*3.16,screenSize.height*0.07)];
    [self addChild:list20 z:25 tag:720];
    [allanmial addObject:list20];
    
    list21 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list21.png"];
    [list21 setPosition:ccp(screenSize.width*3.33,screenSize.height*0.07)];
    [self addChild:list21 z:25 tag:721];
    [allanmial addObject:list21];
    
    list22 = [CCSprite spriteWithSpriteFrameName:@"myzoo_list22.png"];
    [list22 setPosition:ccp(screenSize.width*3.46,screenSize.height*0.07)];
    [self addChild:list22 z:25 tag:722];
    [allanmial addObject:list22];
  
}


- (void)drawthing1 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];

    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing1.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    NSLog(@"thing1~~id==%d",thing1.tag);
    
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing1";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
    
}

- (void)drawthing2 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing2.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    NSLog(@"thing1~~id==%d",thing1.tag);
  
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing2";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
  
}

- (void)drawthing3 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing3.png"];
    [thing1 setPosition:ccp(screenSize.width*0.4,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    NSLog(@"thing1~~id==%d",thing1.tag);
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing3";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing4 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing4.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    NSLog(@"thing1~~id==%d",thing1.tag);
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing4";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing5 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing5.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    NSLog(@"thing1~~id==%d",thing1.tag);
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing5";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing6 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing6.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    NSLog(@"thing1~~id==%d",thing1.tag);
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing6";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing7 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing7.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    NSLog(@"thing1~~id==%d",thing1.tag);
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing7";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing8 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing8.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    NSLog(@"thing1~~id==%d",thing1.tag);
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing8";
    // add the fixture definitions to the body
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing9 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing9.png"];
    [thing1 setPosition:ccp(screenSize.width*0.3 ,screenSize.height*0.7)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
   
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing9";
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing10 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing10.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing10";
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing11 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing11.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing11";
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing12 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing12.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing12";
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing13 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing13.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing13";
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing14 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing14.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing14";
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing15 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing15.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing15";
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing16 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing16.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing16";
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing17 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing17.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing17";
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing18 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing18.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing18";
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing19 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing19.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing19";
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing20 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing20.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing20";
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}
- (void)drawthing21 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing21.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing21";
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}

- (void)drawthing22 {
    CGSize screenSize = [[CCDirector sharedDirector] winSize];
    
    CCSpriteBatchNode *thing1 = [CCSprite spriteWithSpriteFrameName:@"myzoo_thing22.png"];
    [thing1 setPosition:ccp(screenSize.width*0.5 ,screenSize.height*0.5)];
    [self addChild:thing1 z:13 tag:thing1key];
    [allthings addObject:thing1];
    thing1key++;
    
    b2BodyDef bodyDef;
    
    bodyDef.type = b2_dynamicBody;
    bodyDef.position.Set(thing1.position.x/PTM_RATIO, thing1.position.y/PTM_RATIO);
    bodyDef.userData = thing1;
    b2Body *body = _world->CreateBody(&bodyDef);
    
    NSString *name = @"myzoo_thing22";
    [[GB2ShapeCache sharedShapeCache] addFixturesToBody:body forShapeName:name];
    [thing1 setAnchorPoint:[[GB2ShapeCache sharedShapeCache] anchorPointForShape:name]];
    
}



- (void)selectSpriteForTouch:(CGPoint)touchLocation
{
    if (CGRectContainsPoint(game4treasure.boundingBox, touchLocation))
    {
        NSLog(@"faxianla1");
        game4thing=1;
        
    }
    int found=0;
    for (int i=701; i<723; i++) {
        CCSprite *tempspite=(CCSprite *)[self getChildByTag:i];
        if (CGRectContainsPoint(tempspite.boundingBox, touchLocation))
        {
            NSString *thingnum=[NSString stringWithFormat:@"drawthing%d",i-700];
            SEL faSelector=NSSelectorFromString(thingnum);
            [self performSelector:faSelector];
            found=1;
            //[self drawthing1];
        }
        if (found==1) break;


    }
    
    if (CGRectContainsPoint(list1.boundingBox, touchLocation))
    {
      //  [self drawthing1];
    }
    if (CGRectContainsPoint(list2.boundingBox, touchLocation))
    {

    }

    
    
}



- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
    [self selectSpriteForTouch:touchLocation];

    return TRUE;
}

- (void)panForTranslation:(CGPoint)translation {
    
   // CGPoint newPos = ccpAdd(self.position, translation);

    
}


- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint touchLocation = [self convertTouchToNodeSpace:touch];
  //  CGSize size = [[CCDirector sharedDirector] winSize];
    
    CGPoint oldTouchLocation = [touch previousLocationInView:touch.view];
    oldTouchLocation = [[CCDirector sharedDirector] convertToGL:oldTouchLocation];
    oldTouchLocation = [self convertToNodeSpace:oldTouchLocation];
    
  //  CGPoint translation = ccpSub(touchLocation, oldTouchLocation);
    
    

        for (CCSpriteBatchNode *sprite in allthings )
        {
            
            if (CGRectContainsPoint(sprite.boundingBox, oldTouchLocation))
            {
                // NSLog(@"move~~~~%d",sprite.tag);
                sprite.position=touchLocation;
                break;
            }
            
        }


    
    
    

}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event{
    CGPoint touchLocation=[touch locationInView:[touch view]];
    touchLocation=[[CCDirector sharedDirector]convertToGL:touchLocation];
    touchLocation=[self convertToNodeSpace:touchLocation];
    //CGPoint moveDifference=ccpSub(touchLocation,thing1.position);
    
}

-(void) onEnter
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
    
	// must call super here:
	[super onEnter];
}


-(void) onExit
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// must call super here:
    
	[super onExit];
}


-(void) runobsMoveSequencex:(CCSprite*)spider
{
    
	CGPoint belowScreenPosition = CGPointMake(spider.position.x-29,spider.position.y);
	CCMoveTo* move = [CCMoveTo actionWithDuration:0.1f position:belowScreenPosition];
    
	CCSequence* sequence = [CCSequence actions:move,nil];
	[spider runAction:sequence];
    
    
    
}

-(void) runobsMoveSequencey:(CCSprite*)spider
{
    
	CGPoint belowScreenPosition = CGPointMake(spider.position.x,spider.position.y+10);
    
    
    
	CCMoveTo* move = [CCMoveTo actionWithDuration:0.1f position:belowScreenPosition];
    
	CCSequence* sequence = [CCSequence actions:move,nil];
	[spider runAction:sequence];
    
    
    
}
-(void) gampause{
    [[CCDirector sharedDirector] pause];
}

-(void)menu1{
    NSLog(@"menu~~%d~~",phystay);
    if (phystay==0) {
        phystay=1;
    }else{
        phystay=0;
    }
}

-(void)menureset{
    CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetScene4Scene];
    [[CCDirector sharedDirector] replaceScene:newScene];
    
}

-(void)menuphoto{
    NSLog(@"photo~~~~");
   // [self getGLScreenshot];
    [self saveGLScreenshotToPhotosAlbum];
}


-(void)menulistturnright{
    CGSize size = [[CCDirector sharedDirector] winSize];
    
    if (list22.position.x>size.width)//下边没有到最左
    {
        NSLog(@"往右～～～～");
        NSLog(@"list1~x=%f   y=%f",list1.position.x,list1.position.y);
        for (CCSpriteBatchNode *sprite in allanmial)
        {
            CGPoint temp=sprite.position;
            temp.x=temp.x-size.width;
            sprite.position=temp;
           
        }
        NSLog(@"list1~x=%f   y=%f",list1.position.x,list1.position.y);

    }

}
-(void)menulistturnleft
{
    
    CGSize size = [[CCDirector sharedDirector] winSize];
    if (list1.position.x<size.width*0.0)//下边没有到最左
    {
        NSLog(@"往左～～～");
        NSLog(@"list1~x=%f   y=%f",list1.position.x,list1.position.y);

        for (CCSpriteBatchNode *sprite in allanmial)
        {
            CGPoint temp=sprite.position;
            temp.x=temp.x+size.width;
            sprite.position=temp;
        }
        NSLog(@"list1~x=%f   y=%f",list1.position.x,list1.position.y);

    }

}

-(void)menubackgrleft{
    if (padbacknumber>1) {
        padbacknumber--;
         [[SimpleAudioEngine sharedEngine]playEffect:@"map.wav" ];
        CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetScene4Scene_1];
        [[CCDirector sharedDirector] replaceScene:newScene];
        
    }

}

-(void)menubackgrright{
    if (padbacknumber<7) {
          [[SimpleAudioEngine sharedEngine]playEffect:@"map.wav" ];
        padbacknumber++;
        CCScene* newScene = [LoadingScene sceneWithTargetScene:TargetScene4Scene_1];
        [[CCDirector sharedDirector] replaceScene:newScene];
    }

}



- (UIImage*) getGLScreenshot {
    NSInteger myDataLength = 1024 * 768 * 4;
    
    // allocate array and read pixels into it.
    GLubyte *buffer = (GLubyte *) malloc(myDataLength);
    glReadPixels(0, 0, 1024, 768, GL_RGBA, GL_UNSIGNED_BYTE, buffer);
    
    // gl renders "upside down" so swap top to bottom into new array.
    // there's gotta be a better way, but this works.
    GLubyte *buffer2 = (GLubyte *) malloc(myDataLength);
    for(int y = 0; y <768; y++)
    {
        for(int x =0; x <1024 * 4; x++)
        {
            buffer2[(767 - y) * 1024 * 4 + x] = buffer[y * 4 * 1024 + x];
        }
    }
    
    // make data provider with data.
    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL,
                                                              buffer2, myDataLength, NULL);
    
    // prep the ingredients
    int bitsPerComponent = 8;
    int bitsPerPixel = 32;
    int bytesPerRow = 4 * 1024;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGBitmapInfo bitmapInfo = kCGBitmapByteOrderDefault;
    CGColorRenderingIntent renderingIntent = kCGRenderingIntentDefault;
    
    // make the cgimage
    CGImageRef imageRef = CGImageCreate(1024, 768, bitsPerComponent,
                                        bitsPerPixel, bytesPerRow, colorSpaceRef, bitmapInfo, provider,
                                        NULL, NO, renderingIntent);
    
    // then make the uiimage from that
    UIImage *myImage = [UIImage imageWithCGImage:imageRef];
    return myImage;
}

- (void)saveGLScreenshotToPhotosAlbum {
    [[SimpleAudioEngine sharedEngine]playEffect:@"photo.wav" ];
    UIImageWriteToSavedPhotosAlbum([self getGLScreenshot], nil,
                                   nil, nil);
}


-(void) dealloc
{
	CCLOG(@"%@: %@", NSStringFromSelector(_cmd), self);
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

@end
