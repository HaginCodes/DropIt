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
    
    override func didMoveToView(view: SKView) {
        
        slider = SKSpriteNode(imageNamed: "Slider")
        slider.setScale(0.20)
        slider.position = CGPoint(x: self.frame.width / 2, y: 0 + slider.frame.height / 2)
        
        self.addChild(slider)
    
        
       
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
   
               }
    
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
