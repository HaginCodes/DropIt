//
//  GameScene.swift
//  Drop It!
//
//  Created by Christopher Onyango on 10/15/16.
//  Copyright (c) 2016 Christopher Onyango. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var slider = SKSpriteNode()
    var greenTriangle = SKSpriteNode()
    var purpleOctagon = SKSpriteNode()
    var redSquare = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {
        
        slider = SKSpriteNode(imageNamed: "Slider")
        slider.setScale(0.20)
        slider.position = CGPoint(x: self.frame.width / 2, y: 0 + slider.frame.height / 2)
        
        var triangleTimer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: Selector("SpawnShapes"), userInfo: nil, repeats: true)
        self.addChild(slider)
    
        
       
    }
    
    func SpawnShapes(){
        greenTriangle = SKSpriteNode(imageNamed:"greenTriangle")
        purpleOctagon = SKSpriteNode(imageNamed: "purpleOctagon")
        redSquare = SKSpriteNode(imageNamed: "redSquare")
        var MinValue = self.size.width / 8
        var MaxValue = self.size.width - 70
        var SpawnPoint = UInt32(MaxValue - MinValue)
        greenTriangle.position = CGPoint(x: CGFloat(arc4random_uniform(SpawnPoint)), y: self.size.height)
        self.addChild(greenTriangle)
        
        let action = SKAction.moveToY(-30, duration: 2.0)
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
