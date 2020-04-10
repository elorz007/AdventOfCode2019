//
//  GameScene.swift
//  AdventOfCodeGame
//
//  Created by Mikel Elorz on 10.04.20.
//  Copyright © 2020 Mikel Elorz. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    let blockSize = 60
    let playgroundSize = 25
    var arcadeCabinet: ArcadeCabinet?
    override func didMove(to view: SKView) {
        arcadeCabinet = Day13().arcadeCabinet()
        let cameraNode = SKCameraNode()
        let center = blockSize * playgroundSize / 2
        cameraNode.position = CGPoint(x: center, y: center)
        addChild(cameraNode)
        camera = cameraNode

        let drawGrid = true
        if drawGrid {
            for x in 0..<playgroundSize {
                for y in 0..<playgroundSize {
                    let grid = SKShapeNode(rect: CGRect(x: 0, y: 0, width: blockSize, height: blockSize))
                    grid.fillColor = .white
                    grid.strokeColor = .red
                    grid.alpha = 0.2
                    grid.position = CGPoint(x: x * blockSize, y: y*blockSize)
                    let gridLabel = SKLabelNode()
                    gridLabel.verticalAlignmentMode = .center
                    gridLabel.horizontalAlignmentMode = .center
                    gridLabel.fontSize = CGFloat(blockSize) * 0.3
                    gridLabel.position = CGPoint(x: blockSize / 2, y: blockSize / 2)
                    gridLabel.text = "\(x),\(y)"
                    grid.addChild(gridLabel)
                    addChild(grid)
                }
            }
        }

        let label = SKLabelNode(text: "00000")
        label.position = CGPoint(x: blockSize*2, y: -blockSize)
        addChild(label)
    }

    func touchDown(atPoint pos: CGPoint) {
        camera?.position = pos
        print(pos)
    }

    func touchMoved(toPoint pos: CGPoint) {
//        camera?.position = pos
    }

    func touchUp(atPoint pos: CGPoint) {
//        camera?.position = pos
    }

    override func mouseDown(with event: NSEvent) {
        touchDown(atPoint: event.location(in: self))
    }

    override func mouseDragged(with event: NSEvent) {
        touchMoved(toPoint: event.location(in: self))
    }

    override func mouseUp(with event: NSEvent) {
        touchUp(atPoint: event.location(in: self))
    }

    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
//        case 0x31:

        default:
            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
        /*
         keyDown:  keyCode: 123
         keyDown:  keyCode: 126
         keyDown:  keyCode: 125
         keyDown:  keyCode: 124
         */
    }

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
