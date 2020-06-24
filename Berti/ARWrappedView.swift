//
//  ARWrappedView.swift
//
//  Created by Marcello Catelli
//  Copyright © Swift srl. All rights reserved.
//

import UIKit
import SwiftUI
import ARKit

struct ARWrappedView: UIViewRepresentable {

    let sceneView = ARSCNView()
    
    var configuration : ARWorldTrackingConfiguration {
        
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = [.vertical, .horizontal]
        
        return configuration
    }
        
    func makeUIView(context: Context) -> ARSCNView {

        sceneView.delegate = context.coordinator
        sceneView.showsStatistics = false
        sceneView.session.delegate = context.coordinator
        sceneView.debugOptions = [
            //ARSCNDebugOptions.showFeaturePoints,
            //ARSCNDebugOptions.showWorldOrigin
        ]
        
        if let camera = sceneView.pointOfView?.camera {
            camera.wantsHDR = true
            camera.wantsExposureAdaptation = true
            camera.exposureOffset = 0.15
            camera.minimumExposure = 0.0
            camera.maximumExposure = 4.0
        }
        
        let scene = SCNScene()
        sceneView.scene = scene
        
        sceneView.session.run(configuration, options: [.removeExistingAnchors, .resetTracking])
        return sceneView
    }
    
    func updateUIView(_ uiView: ARSCNView, context: Context) { }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    class Coordinator: NSObject, ARSCNViewDelegate, ARSessionDelegate {
                
        func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
            
        }
        
        func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
            
        }
        
        func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
            
        }
        
        func session(_ session: ARSession, didFailWithError error: Error) {

        }
        
        func sessionWasInterrupted(_ session: ARSession) {
            
        }
        
        func sessionInterruptionEnded(_ session: ARSession) {
            
        }
        
    }

}
