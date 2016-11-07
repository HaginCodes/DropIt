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
    static let Score : UInt32 = 0x1 << 8
    static let coinScore : UInt32 = 0x1 << 9
    
}

class GameScene: SKScene, SKPhysicsContactDelegate{
    
    var slider = SKSpriteNode()
    var greenTriangle = SKSpriteNode()
    var orangeHexagon = SKSpriteNode()
    var purpleOctagon = SKSpriteNode()
    var redSquare = SKSpriteNode()
    var coin = SKSpriteNode()
    var score = Int()
    var coinScore = Int()
    var scoreLbl = SKLabelNode()
    var coinLbl = SKLabelNode()
    
    
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
        slider.physicsBody?.dynamic = true
        
       
        var timer = NSTimer.scheduledTimerWithTimeInterval(3.0, target: self, selector: Selector("SpawnShapes"), userInfo: nil, repeats: true)
        self.addChild(slider)
        
        physicsWorld.gravity = CGVectorMake(0, -0.5)
        
        scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 2.5)
        scoreLbl.fontSize = 60
        self.addChild(scoreLbl)
        scoreLbl.zPosition = 5
        
        coinLbl.position = CGPoint(x: self.frame.width / 2 - 100, y: self.frame.height / 2 + self.frame.height / 2.5)
        coinLbl.fontSize = 40
        self.addChild(coinLbl)
        coinLbl.zPosition = 5
        

        
        invisibleBounderies()
        
    }
    
    func didBeginContact(contact: SKPhysicsContact) {
        let firstBody = contact.bodyA
        let secondBody = contact.bodyB
        
       
        if firstBody.categoryBitMask == PhysicsCatergory.Score && secondBody.categoryBitMask == PhysicsCatergory.greenTriangle || firstBody.categoryBitMask == PhysicsCatergory.greenTriangle && secondBody.categoryBitMask == PhysicsCatergory.Score{
            
            score++
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
        }
        
        else if firstBody.categoryBitMask == PhysicsCatergory.Score && secondBody.categoryBitMask == PhysicsCatergory.purpleOctagon || firstBody.categoryBitMask == PhysicsCatergory.purpleOctagon && secondBody.categoryBitMask == PhysicsCatergory.Score{
            
            score++
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
        }
            
        else if firstBody.categoryBitMask == PhysicsCatergory.slider && secondBody.categoryBitMask == PhysicsCatergory.coin || firstBody.categoryBitMask == PhysicsCatergory.coin && secondBody.categoryBitMask == PhysicsCatergory.slider{
            
            coinScore++
            coinLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
            
        }
        
        else if firstBody.categoryBitMask == PhysicsCatergory.slider && secondBody.categoryBitMask == PhysicsCatergory.greenTriangle{
            
        }
        
        else if firstBody.categoryBitMask == PhysicsCatergory.greenTriangle && secondBody.categoryBitMask == PhysicsCatergory.slider{
            
        }
        
        
        
    }
    
    override func didMoveToView(view: SKView) {
        
            createScene()
        
    }
    
    func invisibleBounderies(){
        
        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 1, height: 600)
        scoreNode.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 10  - 150)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOfSize: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.dynamic = false
        scoreNode.physicsBody?.categoryBitMask = PhysicsCatergory.Score
        scoreNode.physicsBody?.collisionBitMask = PhysicsCatergory.Score
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCatergory.greenTriangle
        scoreNode.zRotation = CGFloat(M_PI/2.0)
        scoreNode.zPosition = 1
        scoreNode.color = SKColor.blueColor()
        
        self.addChild(scoreNode)
     
        
    }
    
   
    
    func SpawnShapes(){
        
        
        greenTriangle = SKSpriteNode(imageNamed:"greenTriangle")
        purpleOctagon = SKSpriteNode(imageNamed: "purpleOctagon")
        redSquare = SKSpriteNode(imageNamed: "redSquare")
        coin = SKSpriteNode(imageNamed: "coin")
        
        greenTriangle.physicsBody = SKPhysicsBody(texture: greenTriangle.texture!,size: greenTriangle.texture!.size())
        greenTriangle.physicsBody?.categoryBitMask = PhysicsCatergory.greenTriangle
        greenTriangle.physicsBody?.collisionBitMask = PhysicsCatergory.Score 
        greenTriangle.physicsBody?.contactTestBitMask = PhysicsCatergory.Score
        greenTriangle.physicsBody?.affectedByGravity = true
        greenTriangle.physicsBody?.dynamic = true
        
        purpleOctagon.physicsBody = SKPhysicsBody(texture: purpleOctagon.texture!,size: purpleOctagon.texture!.size())
        purpleOctagon.physicsBody?.categoryBitMask = PhysicsCatergory.purpleOctagon
        purpleOctagon.physicsBody?.collisionBitMask = PhysicsCatergory.Score
        purpleOctagon.physicsBody?.contactTestBitMask = PhysicsCatergory.Score
        purpleOctagon.physicsBody?.affectedByGravity = true
        purpleOctagon.physicsBody?.dynamic = true
        
        coin.physicsBody = SKPhysicsBody(texture: coin.texture!, size: coin.texture!.size())
        coin.physicsBody?.categoryBitMask = PhysicsCatergory.coin
        coin.physicsBody?.collisionBitMask = PhysicsCatergory.coin
        coin.physicsBody?.contactTestBitMask = PhysicsCatergory.slider | PhysicsCatergory.Score
        coin.physicsBody?.affectedByGravity = true
        coin.physicsBody?.dynamic = true
        
        
        let MaxValue = self.size.width / 2 - 200
        let MinValue = self.size.width / 3 * 0.95
        
     

        let rangeMax = UInt32(MaxValue)
        let rangeMin = UInt32(MinValue)
        
    
        slider.zPosition = 1
        coin.zPosition = 2
        greenTriangle.zPosition = 3
        orangeHexagon.zPosition = 4
        purpleOctagon.zPosition = 5
        redSquare.zPosition = 6
        

        purpleOctagon.position = CGPoint(x: CGFloat(arc4random_uniform(rangeMin) + rangeMax), y: self.size.height)
        self.addChild(purpleOctagon)
        
        greenTriangle.position = CGPoint(x: CGFloat(arc4random_uniform(rangeMin) + rangeMax), y: self.size.height)
        self.addChild(greenTriangle)
        
        coin.position = CGPoint(x: CGFloat(arc4random_uniform(rangeMin) + rangeMax), y: self.size.height)
        self.addChild(coin)
        
        greenTriangle.physicsBody?.velocity = CGVectorMake(5, -10)
        purpleOctagon.physicsBody?.velocity = CGVectorMake(5, -10)
        


        
       
        
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
