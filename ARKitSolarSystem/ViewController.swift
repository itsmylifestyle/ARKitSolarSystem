//
//  ViewController.swift
//  ARKitSolarSystem
//
//  Created by Айбек on 04.11.2023.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        //let myBox = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.01)
        
        
        let sun = createPlanet(radius: 0.8, content: "sun.jpg", vector: SCNVector3(x: 0.1, y: -1, z: -1), selfRotationDuration: 100.0, orbitalRotationDuration: 20.0)
        let mercury = createPlanet(radius: 0.02, content: "Mercury.jpg", vector: SCNVector3(x: 1.3, y: -1, z: -1),selfRotationDuration: 10.0, orbitalRotationDuration: 1000.0)
        let venus = createPlanet(radius: 0.02, content: "venus.jpg", vector: SCNVector3(x: 1.5, y: -1, z: -1),selfRotationDuration: 12.0, orbitalRotationDuration: 225.5)
        let earth = createPlanet(radius: 0.02, content: "earth.jpg", vector: SCNVector3(x: 1.7, y: -1, z: -1),selfRotationDuration: 10.0, orbitalRotationDuration: 20.0)
        let mars = createPlanet(radius: 0.02, content: "mars.jpg", vector: SCNVector3(x: 1.9, y: -1, z: -1),selfRotationDuration: 10.0, orbitalRotationDuration: 20.0)
        let jupiter = createPlanet(radius: 0.13, content: "jupiter.jpg", vector: SCNVector3(x: 2.4, y: -1, z: -1),selfRotationDuration: 10.0, orbitalRotationDuration: 20.0)
        let saturn = createPlanet(radius: 0.11, content: "saturn.jpg", vector: SCNVector3(x: 2.8, y: -1, z: -1),selfRotationDuration: 10.0, orbitalRotationDuration: 20.0)
        let uranus = createPlanet(radius: 0.06, content: "uranus.png", vector: SCNVector3(x: 3.2, y: -1, z: -1),selfRotationDuration: 10.0, orbitalRotationDuration: 20.0)
        let pluto = createPlanet(radius: 0.06, content: "pluto.jpg", vector: SCNVector3(x: 3.6, y: -1, z: -1),selfRotationDuration: 10.0, orbitalRotationDuration: 20.0)
        
        
        let arr = [sun, mercury, venus, earth, mars, jupiter, saturn, uranus, pluto]
        sceneView.scene.rootNode.addChildNode(sun)
        sceneView.scene.rootNode.addChildNode(mercury)
        sceneView.scene.rootNode.addChildNode(venus)
        sceneView.scene.rootNode.addChildNode(earth)
        sceneView.scene.rootNode.addChildNode(mars)
        sceneView.scene.rootNode.addChildNode(jupiter)
        sceneView.scene.rootNode.addChildNode(saturn)
        sceneView.scene.rootNode.addChildNode(uranus)
        sceneView.scene.rootNode.addChildNode(pluto)

        sceneView.automaticallyUpdatesLighting = true
    }
    
    func createPlanet(radius: CGFloat, content: String, vector: SCNVector3, selfRotationDuration: TimeInterval, orbitalRotationDuration: TimeInterval) -> SCNNode {
        let sphere = SCNSphere(radius: radius)
        let boxMaterials = SCNMaterial()
        boxMaterials.diffuse.contents = UIImage(named: "art.scnassets/\(content)")
        sphere.materials = [boxMaterials]
        
        let node = SCNNode()
        node.position = vector
        node.geometry = sphere
        
        // Create a rotation action for self-rotation
        let selfRotation = SCNAction.rotateBy(x: 0, y: .pi * 2, z: 0, duration: selfRotationDuration) // Rotate 360 degrees around the y-axis
        
        // Repeat the self-rotation action forever for continuous self-rotation
        let selfRotationForever = SCNAction.repeatForever(selfRotation)
        
        // Run the self-rotation action on the node
        node.runAction(selfRotationForever)
        
        // Create a rotation action for orbital motion (revolution around the sun)
        let orbitalRotation = SCNAction.moveBy(x: 0, y: .pi / 180, z: 0, duration: orbitalRotationDuration) // Rotate 360 degrees around the y-axis
        
        // Repeat the orbital rotation action forever for continuous orbital motion
        let orbitalRotationForever = SCNAction.repeatForever(orbitalRotation)
        
        // Run the orbital rotation action on the node
        node.runAction(orbitalRotationForever)
        
        return node
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
