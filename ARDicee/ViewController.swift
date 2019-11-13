//
//  ViewController.swift
//  ARDicee
//
//  Created by Pauli Sairanen on 14/10/2019.
//  Copyright © 2019 Pauli Sairanen. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate, SCNPhysicsContactDelegate, ARSessionDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sceneView.debugOptions = ARSCNDebugOptions.showWorldOrigin
        sceneView.showsStatistics = true
        // With ARkit enabled, the points where objects can be placed is shown
        //  self.sceneView.debugOptions = [ARSCNDebugOptions.
        let gameScene = SCNScene()
        sceneView.scene = gameScene
        
        // Set the view's delegate
        sceneView.delegate = self
        sceneView.scene.physicsWorld.contactDelegate = self
        
        // MARK: _____ Collision detection body types _____
        enum BodyType: Int {
            case planet = 1
            case projectile = 2
        }
        
        // MARK: ______ Creating planets as 3D objects _____
        let sun = SCNSphere(radius: 0.7)
        let mercury = SCNSphere(radius: 0.03)
        let venus = SCNSphere(radius: 0.095)
        let earth = SCNSphere(radius: 0.06)
        let mars = SCNSphere(radius: 0.053)
        let jupiter = SCNSphere(radius: 0.3)
        let saturn = SCNSphere(radius: 0.2)
        let uranus = SCNSphere(radius: 0.2)
        let neptune = SCNSphere(radius: 0.23)
        
        // MARK:_____ Adding texture maps to planets _____
        let materialSun = SCNMaterial()
        materialSun.diffuse.contents = UIImage(named: "art.scnassets/2k_sun.jpg")
        sun.materials = [materialSun]
        
        let materialMercury = SCNMaterial()
        materialMercury.diffuse.contents = UIImage(named: "art.scnassets/2k_mercury.jpg")
        mercury.materials = [materialMercury]
        
        let materialVenus = SCNMaterial()
        materialVenus.diffuse.contents = UIImage(named: "art.scnassets/2k_venus_surface.jpg")
        venus.materials = [materialVenus]
        
        let materialEarth = SCNMaterial()
        materialEarth.diffuse.contents = UIImage(named: "art.scnassets/2k_earth_daymap.jpg")
        earth.materials = [materialEarth]
        
        let materialMars = SCNMaterial()
        materialMars.diffuse.contents = UIImage(named: "art.scnassets/2k_mars.jpg")
        mars.materials = [materialMars]
        
        let materialJupiter = SCNMaterial()
        materialJupiter.diffuse.contents = UIImage(named: "art.scnassets/2k_jupiter.jpg")
        jupiter.materials = [materialJupiter]
        
        let materialSaturn = SCNMaterial()
        materialSaturn.diffuse.contents = UIImage(named: "art.scnassets/2k_saturn.jpg")
        saturn.materials = [materialSaturn]
        
        let materialUranus = SCNMaterial()
        materialUranus.diffuse.contents = UIImage(named: "art.scnassets/2k_uranus.jpg")
        uranus.materials = [materialUranus]
        
        let materialNeptune = SCNMaterial()
        materialNeptune.diffuse.contents = UIImage(named: "art.scnassets/2k_neptune.jpg")
        neptune.materials = [materialNeptune]
        
        // MARK:_____ Creating points in space where the 3D objects will be shown at _____
        let locationSun = SCNNode()
        locationSun.name = "Sun"
        locationSun.position = SCNVector3(x: 0, y: 0.0, z: -10.0)
        locationSun.geometry = sun
        locationSun.physicsBody = SCNPhysicsBody(type: .static, shape: nil)
        locationSun.physicsBody!.isAffectedByGravity = false
        locationSun.physicsBody!.categoryBitMask = BodyType.planet.rawValue
        locationSun.physicsBody!.collisionBitMask = BodyType.projectile.rawValue
        locationSun.physicsBody!.contactTestBitMask = BodyType.projectile.rawValue
        
        let locationMercury = SCNNode()
        locationMercury.name = "Mercury"
        locationMercury.position = SCNVector3(x: Float(sun.radius) + 1, y: 0 , z: 0)
        locationMercury.geometry = mercury
        locationMercury.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        locationMercury.physicsBody?.isAffectedByGravity = false
        locationMercury.physicsBody?.categoryBitMask = BodyType.planet.rawValue
        locationMercury.physicsBody?.collisionBitMask = BodyType.projectile.rawValue
        locationMercury.physicsBody?.categoryBitMask = BodyType.projectile.rawValue
        
        let locationVenus = SCNNode()
        locationVenus.name = "Venus"
        locationVenus.position = SCNVector3(x: Float(sun.radius) + 2, y: 0, z: 0)
        locationVenus.geometry = venus
        locationVenus.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        locationVenus.physicsBody?.isAffectedByGravity = false
        locationVenus.physicsBody?.categoryBitMask = BodyType.planet.rawValue
        locationVenus.physicsBody?.collisionBitMask = BodyType.projectile.rawValue
        locationVenus.physicsBody?.categoryBitMask = BodyType.projectile.rawValue
        
        let locationEarth = SCNNode()
        locationEarth.name = "Earth"
        locationEarth.position = SCNVector3(x: 0, y: 0, z: Float(sun.radius) + 3)
        locationEarth.geometry = earth
        locationEarth.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        locationEarth.physicsBody?.isAffectedByGravity = false
        locationEarth.physicsBody?.categoryBitMask = BodyType.planet.rawValue  // Defines the category where the shape belongs to
        locationEarth.physicsBody?.collisionBitMask = BodyType.projectile.rawValue     // Defines the category which causes collisions
        locationEarth.physicsBody?.contactTestBitMask = BodyType.projectile.rawValue
        
        let locationMars = SCNNode()
        locationMars.name = "Mars"
        locationMars.position = SCNVector3(x: Float(sun.radius) + 3.5, y: 0, z:0)
        locationMars.geometry = mars
        locationMars.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        locationMars.physicsBody?.isAffectedByGravity = false
        locationMars.physicsBody?.categoryBitMask = BodyType.planet.rawValue
        locationMars.physicsBody?.collisionBitMask = BodyType.projectile.rawValue
        locationMars.physicsBody?.categoryBitMask = BodyType.projectile.rawValue
        
        let locationJupiter = SCNNode()
        locationJupiter.name = "Jupiter"
        locationJupiter.position = SCNVector3(x: Float(sun.radius) + 5, y: 0, z: 0)
        locationJupiter.geometry = jupiter
        locationJupiter.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        locationJupiter.physicsBody?.isAffectedByGravity = false
        locationJupiter.physicsBody?.categoryBitMask = BodyType.planet.rawValue
        locationJupiter.physicsBody?.collisionBitMask = BodyType.projectile.rawValue
        locationJupiter.physicsBody?.contactTestBitMask = BodyType.projectile.rawValue
        
        let locationSaturn = SCNNode()
        locationSaturn.name = "Saturn"
        locationSaturn.position = SCNVector3(x: Float(sun.radius) + 6, y: 0, z: 0)
        locationSaturn.geometry = saturn
        locationSaturn.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        locationSaturn.physicsBody?.isAffectedByGravity = false
        locationSaturn.physicsBody?.categoryBitMask = BodyType.planet.rawValue
        locationSaturn.physicsBody?.collisionBitMask = BodyType.projectile.rawValue
        locationSaturn.physicsBody?.contactTestBitMask = BodyType.projectile.rawValue
        
        let locationUranus = SCNNode()
        locationUranus.name = "Uranus"
        locationUranus.position = SCNVector3(x: Float(sun.radius) + 7, y: 0, z: 0)
        locationUranus.geometry = uranus
        locationUranus.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        locationUranus.physicsBody?.isAffectedByGravity = false
        locationUranus.physicsBody?.categoryBitMask = BodyType.planet.rawValue
        locationUranus.physicsBody?.collisionBitMask = BodyType.projectile.rawValue
        locationUranus.physicsBody?.contactTestBitMask = BodyType.projectile.rawValue
        
        let locationNeptune = SCNNode()
        locationNeptune.name = "Neptune"
        locationNeptune.position = SCNVector3(x: Float(sun.radius) + 8, y: 0, z: 0)
        locationNeptune.geometry = neptune
        locationNeptune.physicsBody = SCNPhysicsBody(type: .kinematic, shape: nil)
        locationNeptune.physicsBody?.isAffectedByGravity = false
        locationNeptune.physicsBody?.categoryBitMask = BodyType.planet.rawValue
        locationNeptune.physicsBody?.collisionBitMask = BodyType.projectile.rawValue
        locationNeptune.physicsBody?.contactTestBitMask = BodyType.projectile.rawValue
        
        
        // MARK: _____ Anchors for plane orbits _____
        // Planets are set as childs to the anchor, so they will orbit according to anchor rotation
        let anchorLocationMercury = SCNNode()
        anchorLocationMercury.position = SCNVector3(locationSun.position.x, locationSun.position.y, locationSun.position.z)
        anchorLocationMercury .addChildNode(locationMercury)
        
        let anchorLocationVenus = SCNNode()
        anchorLocationVenus.position = SCNVector3(locationSun.position.x, locationSun.position.y, locationSun.position.z)
        anchorLocationVenus .addChildNode(locationVenus)
        
        let anchorLocationEarth = SCNNode()
        anchorLocationEarth.position = SCNVector3(locationSun.position.x, locationSun.position.y, locationSun.position.z)
        anchorLocationEarth .addChildNode(locationEarth)
        
        let anchorLocationMars = SCNNode()
        anchorLocationMars.position = SCNVector3(locationSun.position.x, locationSun.position.y, locationSun.position.z)
        anchorLocationMars .addChildNode(locationMars)
        
        let anchorLocationJupiter = SCNNode()
        anchorLocationJupiter.position = SCNVector3(locationSun.position.x, locationSun.position.y, locationSun.position.z)
        anchorLocationJupiter .addChildNode(locationJupiter)
        
        let anchorLocationSaturn = SCNNode()
        anchorLocationSaturn.position = SCNVector3(locationSun.position.x, locationSun.position.y, locationSun.position.z)
        anchorLocationSaturn .addChildNode(locationSaturn)
        
        let anchorLocationUranus = SCNNode()
        anchorLocationUranus.position = SCNVector3(locationSun.position.x, locationSun.position.y, locationSun.position.z)
        anchorLocationUranus .addChildNode(locationUranus)
        
        let anchorLocationNeptune = SCNNode()
        anchorLocationNeptune.position = SCNVector3(locationSun.position.x, locationSun.position.y, locationSun.position.z)
        anchorLocationNeptune .addChildNode(locationNeptune)
        
        
        // MARK: _____ Rotate function to create orbits _____
        // Rotates the Achors which will create the orbits of the planets
        // 6.28318521 rads = 360°
        let fullRound = CGFloat(6.28318531)
        let earthSpeed = 1.0
        anchorLocationMercury .runAction(SCNAction .repeatForever(SCNAction .rotateBy(x: 0, y: fullRound, z: 0, duration: earthSpeed * 0.2)))
        anchorLocationVenus .runAction(SCNAction .repeatForever(SCNAction .rotateBy(x: 0, y: fullRound, z: 0, duration: earthSpeed * 0.6)))
        anchorLocationEarth .runAction(SCNAction .repeatForever(SCNAction .rotateBy(x: 0, y: fullRound, z: 0, duration: earthSpeed)))
        anchorLocationMars .runAction(SCNAction .repeatForever(SCNAction .rotateBy(x: 0, y: fullRound, z: 0, duration: earthSpeed * 1.9)))
        anchorLocationJupiter .runAction(SCNAction .repeatForever(SCNAction .rotateBy(x: 0, y: fullRound, z: 0, duration: earthSpeed * 11.9)))
        anchorLocationSaturn .runAction(SCNAction .repeatForever(SCNAction .rotateBy(x: 0, y: fullRound, z: 0, duration: earthSpeed * 29.5)))
        anchorLocationUranus .runAction(SCNAction .repeatForever(SCNAction .rotateBy(x: 0, y: fullRound, z: 0, duration: earthSpeed * 84)))
        anchorLocationNeptune .runAction(SCNAction .repeatForever(SCNAction .rotateBy(x: 0, y: fullRound, z: 0, duration: earthSpeed * 164.8)))
        
        
        // MARK: _____ Placing planet anchors as child components to the root _____
        sceneView.scene.rootNode.addChildNode(locationSun)
        sceneView.scene.rootNode.addChildNode(anchorLocationMercury)
        sceneView.scene.rootNode.addChildNode(anchorLocationVenus)
        sceneView.scene.rootNode.addChildNode(anchorLocationEarth)
        sceneView.scene.rootNode.addChildNode(anchorLocationMars)
        sceneView.scene.rootNode.addChildNode(anchorLocationJupiter)
        sceneView.scene.rootNode.addChildNode(anchorLocationSaturn)
        sceneView.scene.rootNode.addChildNode(anchorLocationUranus)
        sceneView.scene.rootNode.addChildNode(anchorLocationNeptune)
        
        sceneView.autoenablesDefaultLighting = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if ARWorldTrackingConfiguration.isSupported {
            // Create a session configuration
            let configuration = ARWorldTrackingConfiguration()
            
            // Adding setup to detect planes to place objects onto
            configuration.planeDetection = .horizontal
            print("Session is supported = \(ARConfiguration.isSupported)")
            print("World Tracking is supported = \(ARWorldTrackingConfiguration.isSupported)")
            
            // Run the view's session
            sceneView.session.run(configuration)
        }
        else {
            // _ = let configuration
            _ = ARConfiguration.self
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        sceneView.session.pause()
    }
    
    
    // MARK: _____ Detecting collisions between objects _____
    func physicsWorld(_ world: SCNPhysicsWorld, didBegin contact: SCNPhysicsContact) {
        print("collision detected!")
        print("Node A: \(String(describing: contact.nodeA.name)) vs Node B: \(String(describing: contact.nodeB.name))")
        print("Node A bitmask: \(contact.nodeA.physicsBody!.categoryBitMask) vs NodeB: \(contact.nodeB.physicsBody!.categoryBitMask)")
        
        // Removing node from view
        if (contact.nodeA.name == "Sun" || contact.nodeB.name == "Sun") {
            print("Sun cannot be deleted>:(")
            if (contact.nodeA.name == "Meteor") {
                contact.nodeA.removeFromParentNode()
                print("Meteor hit the sun. Meteor burned to crisp")
            }
            else {
                contact.nodeB.removeFromParentNode()
                print("Meteor hit the sun. Meteor burned to crisp")
            }
            return
        }
            // If NodeA = planet
        else if ( contact.nodeA.physicsBody!.categoryBitMask == 1) {
            print("Node A = planet")
            
            // Get the radius of the NodeA
            if let planetRadius = (contact.nodeA.geometry as? SCNSphere)?.radius {
                print("Explosion happens here!")
                explosion(position: contact.nodeA.worldPosition, planetSize: planetRadius)
                contact.nodeA.parent!.removeFromParentNode()
                contact.nodeB.removeFromParentNode()
            }
        }
        else {
            print("Node B = planet")
            contact.nodeB.parent!.removeFromParentNode()
            contact.nodeA.removeFromParentNode()
        }
    }
    
    // MARK: _____ Touch functions _____
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("Screen touched")
        shoot()
    }
    
    func shoot() {
        var meteorNode = SCNNode()
        let tempScene = SCNScene(named: "art.scnassets/meteor.scn")
        meteorNode = tempScene!.rootNode
        meteorNode.scale = SCNVector3(0.0001, 0.0001, 0.0001)
        meteorNode.name = "Meteor"
        meteorNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
        meteorNode.physicsBody?.isAffectedByGravity = false
        meteorNode.physicsBody?.categoryBitMask = 2
        
        // MARK: _____ Getting the current position and direction of the camera _____
        guard let frame = sceneView.session.currentFrame
            else { return } //1
        let camMatrix = SCNMatrix4(frame.camera.transform)
        let direction = SCNVector3Make(-camMatrix.m31 * 5.0, -camMatrix.m32 * 5.0, -camMatrix.m33 * 5.0) //2
        let position = SCNVector3Make(camMatrix.m41, camMatrix.m42, camMatrix.m43) //3
        meteorNode.position = position
        
        //    meteorNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 3, y: 2, z: 0, duration: 4)))
        meteorNode.physicsBody?.applyForce (direction,  asImpulse: true)
        sceneView.scene.rootNode.addChildNode(meteorNode)
        
        // MARK: _____ Removing projectiles from scene after a set amount of time _____
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            print("Removing projectile from scene")
            meteorNode.removeFromParentNode()
        }
    }
    
    func explosion(position: SCNVector3, planetSize: CGFloat) {
        
        // MARK: _____ Creating a particle system for explosion effect _____
        
        let exp = SCNParticleSystem()
        exp.isAffectedByGravity = false
        exp.isLightingEnabled = true
        exp.birthDirection = .random
        exp.particleSize = 0.01
        exp.birthRate = 100000
        exp.emissionDuration = 1
        exp.emitterShape = SCNSphere(radius: 0.01)
        exp.particleLifeSpan = 3
        
        // MARK: _____ Adjusting the explosion size according to planet radius _____
        exp.particleVelocity = 2 / planetSize
        exp.particleColor = UIColor.yellow
        
        let explosionNode = SCNNode()
        
        _ = SCNAction.customAction(duration: 3) { (explosionNode, _) in
            explosionNode.light?.attenuationStartDistance = 1000
            explosionNode.light?.attenuationEndDistance = 0
        }
        
    //    explosionNode.light?.intensity = 1000
        explosionNode.addParticleSystem(exp)
        explosionNode.position = position
        self.sceneView.scene.rootNode.addChildNode(explosionNode)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            print("Removing explosion node from scene")
            explosionNode.removeFromParentNode()
            
        }
        
        // MARK: _____ Creating a random amount of debris meteors from the explosion _____
        DispatchQueue.global(qos: .background).async {
            
            // Random value for how many debree parts will be spawned from explosion
            let amountOfRocks = Int.random(in: 5..<20)
            for _ in 0...amountOfRocks {
                
                var meteorNode = SCNNode()
                let meteorScene = SCNScene(named: "art.scnassets/meteor.scn")
                meteorNode = meteorScene!.rootNode
                
                // Adjusting the debree size depending on how many parts there are
                switch amountOfRocks {
                case 0:
                    print("No rocks spawned")
                    
                case 5..<10:
                    let randomSize = CGFloat.random(in: 0.0001 ..< 0.0005)
                    meteorNode.scale = SCNVector3(randomSize, randomSize, randomSize)
                    
                case 11..<15:
                    let randomSize = CGFloat.random(in: 0.00005 ..< 0.00009)
                    meteorNode.scale = SCNVector3(randomSize, randomSize, randomSize)
                    
                case 16..<20:
                    let randomSize = CGFloat.random(in: 0.00001 ..< 0.00005)
                    meteorNode.scale = SCNVector3(randomSize, randomSize, randomSize)
                    
                default:
                    print("This is the default case")
                }
                
                // MARK: _____ Giving the created debris physics _____
                meteorNode.name = "Meteor"
                meteorNode.physicsBody = SCNPhysicsBody(type: .dynamic, shape: nil)
                meteorNode.physicsBody?.isAffectedByGravity = false
                meteorNode.position = position
                meteorNode.physicsBody?.applyForce (SCNVector3(CGFloat.random(in: -1 ..< 1), CGFloat.random(in: -1 ..< 1), CGFloat.random(in: -1 ..< 1)),  asImpulse: true)
                
                // Adding the debris meteor into the scene
                self.sceneView.scene.rootNode.addChildNode(meteorNode)
                
                // MARK: _____ Removing projectiles from scene after a set amount of time _____
                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
                    print("Removing projectile from scene")
                    meteorNode.removeFromParentNode()
                    
                }
            }
        }
    }
}


