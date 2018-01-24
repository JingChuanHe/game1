//
//  GameViewController.swift
//  game1
//
//  Created by jing on 1/23/18.
//  Copyright © 2018 jing. All rights reserved.
//

import UIKit
import SpriteKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scence = GameScene(size:CGSize(width:2048,height:1536))
        
        let skView = self.view as! SKView
        
        
        skView.ignoresSiblingOrder = true
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        scence.scaleMode = .aspectFill
        skView.presentScene(scence)
    }
    
    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    

    
}
