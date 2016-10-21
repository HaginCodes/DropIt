//
//  GameScene.swift
//  Drop It!
//
//  Created by Christopher Onyango on 10/15/16.
//  Copyright (c) 2016 Christopher Onyango. All rights reserved.
//

import SpriteKit

struct PhysicsCatergory {
    static let slider : UInt32 = 0x1 << 1
    static let coin : UInt32 = 0x1 << 2
    static let greenTriangle : UInt32 = 0x1 << 3
    static let orangeHexagon : UInt32 = 0x1 << 4
    static let purpleOctagon : UInt32 = 0x1 << 5
    static let redSquare : UInt32 = 0x1 << 6
    static let Wall : UInt32 = 0x1 << 7
    
}

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var slider = SKSpriteNode()
    var greenTriangle = SKSpriteNode()
    var orangeHexagon = SKSpriteNode()
    var purpleOctagon = SKSpriteNode()
    var redSquare = SKSpriteNode()
    var coin = SKSpriteNode()
    var wallPair = SKNode()
    
    
    func createScene(){
        
        physicsWorld.contactDelegate = self
        
        slider = SKSpriteNode(imageNamed: "Slider")
        slider.setScale(0.20)
        slider.position = CGPoint(x: self.frame.width / 2, y: 0 + slider.frame.height / 2)
        
        
        slider.physicsBody = SKPhysicsBody(rectangleOfSize: slider.size)
        slider.physicsBody?.categoryBitMask = PhysicsCatergory.slider
        slider.physicsBody?.collisionBitMask = PhysicsCatergory.coin | PhysicsCatergory.greenTriangle | PhysicsCatergory.orangeHexagon | PhysicsCatergory.purpleOctagon | PhysicsCatergory.redSquare
        slider.physicsBody?.contactTestBitMask = PhysicsCatergory.coin | PhysicsCatergory.greenTriangle | PhysicsCatergory.orangeHexagon | PhysicsCatergory.purpleOctagon | PhysicsCatergory.redSquare
        slider.physicsBody?.affectedByGravity = false
        slider.physicsBody?.dynamic = false
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("SpawnShapes"), userInfo: nil, repeats: true)
        self.addChild(slider)

        
    }
    
    override func didMoveToView(view: SKView) {
        
            createScene()
        
        
    }
    
    func invisibleBounderies(){
        
        wallPair = SKNode()
        wallPair.name = "wallPair"
        
        let topWall = SKSpriteNode(imageNamed: "Wall")
        let btmWall = SKSpriteNode(imageNamed: "Wall")
        
        topWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 + 350)
        btmWall.position = CGPoint(x: self.frame.width + 25, y: self.frame.height / 2 - 350)
        
        topWall.physicsBody = SKPhysicsBody(rectangleOfSize: topWall.size)
        topwall.physicsBody?.catergoryBitMask = PhysicsCatergory.slider
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        
        var firstBody : SKPhysicsBody = contact.bodyA
        var secondBody : SKPhysicsBody = contact.bodyB
    
        if((firstBody.categoryBitMask == PhysicsCatergory.slider) && (secondBody.categoryBitMask == PhysicsCatergory.greenTriangle)){
            
            CollisionWithSlider(firstBody.node as! SKSpriteNode, greenTriangle: secondBody.node as! SKSpriteNode)
        }
        
    }
        
        func CollisionWithSlider(slider: SKSpriteNode, greenTriangle: SKSpriteNode){
            NSLog("hallo")
        }
    
    func SpawnShapes(){
        
        greenTriangle = SKSpriteNode(imageNamed:"greenTriangle")
        purpleOctagon = SKSpriteNode(imageNamed: "purpleOctagon")
        redSquare = SKSpriteNode(imageNamed: "redSquare")
        coin = SKSpriteNode(imageNamed: "coin")
        
        greenTriangle.physicsBody = SKPhysicsBody(rectangleOfSize: greenTriangle.size)
        greenTriangle.physicsBody?.categoryBitMask = PhysicsCatergory.greenTriangle
        greenTriangle.physicsBody?.contactTestBitMask = PhysicsCatergory.slider
        greenTriangle.physicsBody?.affectedByGravity = false
        greenTriangle.physicsBody?.dynamic = false
        
        var MinValue = self.size.width / 8
        var MaxValue = self.size.width - 150
        var SpawnPoint = UInt32(MaxValue - MinValue)
        
        let action = SKAction.moveToY(-30, duration: 2.0)
       
        
        slider.zPosition = 1
        coin.zPosition = 2
        greenTriangle.zPosition = 3
        orangeHexagon.zPosition = 4
        purpleOctagon.zPosition = 5
        redSquare.zPosition = 6
        
        
        
        
        greenTriangle.position = CGPoint(x: CGFloat(arc4random_uniform(SpawnPoint)), y: self.size.height)
        self.addChild(greenTriangle)
        greenTriangle.runAction(SKAction.repeatActionForever(action))
        
       
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            slider.position.x = location.x
        }
        
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch in touches {
            let location = touch.locationInNode(self)
            
            slider.position.x = location.x
        }
        
        
    }
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
