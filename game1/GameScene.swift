//
//  GameScene.swift
//  game1
//
//  Created by jing on 1/23/18.
//  Copyright © 2018 jing. All rights reserved.
//

import SpriteKit
import GameplayKit
/*
 表示图像的类叫做材质
 */
class GameScene: SKScene {
    
    let zombie = SKSpriteNode(imageNamed:"zombie1")
    
    // 精灵移动初始设置
    let zombieMovePointsPerSet:CGFloat = 480.0
    var velocity = CGPoint.zero
    
    // 记录相邻两次的点击时间
    var lastUpdateTime:TimeInterval = 0
    var dt:TimeInterval = 0
    
    // 长按暂停
    var isClear:Bool = false
    
    
    override func didMove(to view: SKView) {
        
        //长按监听
        let longPress = UILongPressGestureRecognizer(target:self,
                                                     action:#selector(longPressDid(_:)))
        self.view?.addGestureRecognizer(longPress)
        
        
        backgroundColor = SKColor.black
        let background = SKSpriteNode(imageNamed:"background1")//,name
        background.position = CGPoint(x:size.width/2, y:size.height/2)
        background.zPosition = -1
        addChild(background)
        
        zombie.position = CGPoint(x:400, y:400)
        addChild(zombie)
        
    }
    
    @objc func longPressDid(_ sender: UILongPressGestureRecognizer){
        
        
        isClear = !isClear
    }
    
    func moveZombieToward(location:CGPoint){
        
        let offset = CGPoint(x:location.x - zombie.position.x,y:location.y - zombie.position.y)
        let length = sqrt(Double(offset.x * offset.x + offset.y * offset.y))
        
        let direction = CGPoint(x:offset.x / CGFloat(length),y:offset.y / CGFloat(length))
        velocity = CGPoint(x:direction.x * zombieMovePointsPerSet,y:direction.y * zombieMovePointsPerSet)
        
        
    }
    
    // 记录每次更新的时间
    override func update(_ currentTime: TimeInterval) {
        print("update····,\(currentTime)")
        if isClear {
            velocity = CGPoint.zero
            
            lastUpdateTime = 0
            dt = 0
            zombie.position = CGPoint(x:400, y:400)
        }else{
            if lastUpdateTime > 0 {
                
                dt = currentTime - lastUpdateTime
            }else{
                dt = 0
            }
            
            lastUpdateTime = currentTime
            moveSprite(sprite: zombie, velocity: velocity)
            boundCheckZombie()
            roateSpriate(sprite: zombie, direction: velocity)
        }
        
        
    }
    
    func moveSprite(sprite:SKSpriteNode ,velocity:CGPoint){
        
        let amountToMove = CGPoint(x:velocity.x * CGFloat(dt),y:velocity.y * CGFloat(dt))
        
        sprite.position = CGPoint(x: sprite.position.x+amountToMove.x, y: sprite.position.y + amountToMove.y)
    }
    
    func sceneTouched(touchLoaction:CGPoint){
        moveZombieToward(location:touchLoaction)
    }
    
    // 记录每次的事件
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
//        isClear = !isClear
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLoaction: touchLocation)
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
//        isClear = !isClear
        let touchLocation = touch.location(in: self)
        sceneTouched(touchLoaction: touchLocation)
    }
 
    
    
    
    // 检测边界
    func boundCheckZombie(){
        
        let bottomLeft = CGPoint.zero
        let topRight = CGPoint(x:size.width,y:size.height)
        
        if zombie.position.x <= bottomLeft.x {
            zombie.position.x = bottomLeft.x
            velocity.x = -velocity.x
        }
        if zombie.position.y <= bottomLeft.y {
            zombie.position.y = bottomLeft.y
            velocity.y = -velocity.y
        }
        
        if zombie.position.x >= topRight.x {
            zombie.position.x = topRight.x
            velocity.x = -velocity.x
        }
        if zombie.position.y >= topRight.y {
            zombie.position.y = topRight.y
            velocity.y = -velocity.y
        }
    }
    
    // 旋转精灵
    func roateSpriate(sprite:SKSpriteNode,direction:CGPoint){
        
        UIView.animate(withDuration: 0.25) {
            
            sprite.zRotation = CGFloat(atan2(Double(direction.y),Double(direction.x)))
        }
    }
}











