//
//  ViewController.swift
//  chem-lab-practical
//
//  Created by macos on 6/25/18.
//  Copyright © 2018 cse438. All rights reserved.
//

import UIKit
import Metal
import CoreMotion

class ViewController: UIViewController {
    
    
    
    let gravity : Float = 9.80665
    let ptmRatio: Float = 32.0
    let particleRadius: Float = 9
    var particleSystem: UnsafeMutableRawPointer!
    var device: MTLDevice! = nil
    var metalLayer: CAMetalLayer! = nil
    var particleCount: Int = 0
    var vertexBuffer: MTLBuffer! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        LiquidFun.createWorld(withGravity: Vector2D(x: 0, y: -gravity))
        
        particleSystem = LiquidFun.createParticleSystem(withRadius: particleRadius / ptmRatio, dampingStrength: 0.2, gravityScale: 1, density: 1.2)
        
        let screenSize: CGSize = UIScreen.main.bounds.size
        let screenWidth = Float(screenSize.width)
        let screenHeight = Float(screenSize.height)
        
        LiquidFun.createParticleBox(forSystem: particleSystem, position: Vector2D(x: screenWidth * 0.5 / ptmRatio, y: screenHeight * 0.5 / ptmRatio), size: Size2D(width: 50 / ptmRatio, height: 50 / ptmRatio))
        
        createMetalLayer()
        refreshVertexBuffer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func printParticleInfo() {
        let count = Int(LiquidFun.particleCount(forSystem: particleSystem))
        print("There are \(count) particles present")
        
        let positions = (LiquidFun.particlePositions(forSystem: particleSystem)).assumingMemoryBound(to: Vector2D.self)
        
        for i in 0..<count {
            let position = positions[i]
            print("particle: \(i) position: (\(position.x), \(position.y))")
        }
    }
    
    func createMetalLayer() {
        device = MTLCreateSystemDefaultDevice()
        
        metalLayer = CAMetalLayer()
        metalLayer.device = device
        metalLayer.pixelFormat = .BGRA8Unorm
        metalLayer.framebufferOnly = true
        metalLayer.frame = view.layer.frame
        view.layer.addSublayer(metalLayer)
    }
    
    func refreshVertexBuffer () {
        particleCount = Int(LiquidFun.particleCount(forSystem: particleSystem))
        let positions = LiquidFun.particlePositions(forSystem: particleSystem)
        let bufferSize = MemoryLayout<Float>.size * particleCount * 2
        vertexBuffer = device.makeBuffer(bytes: positions!, length: bufferSize, options: [])
    }

}

