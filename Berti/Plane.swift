//
//  Plane.swift
//  GallARy
//
//  Created by Marcello Catelli
//  Copyright © Swift srl. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class Plane: SCNNode {
	
	var anchor : ARPlaneAnchor
	var planeGeometry : SCNPlane!
	
	init(anchor: ARPlaneAnchor, image:UIImage) {
		
		self.anchor = anchor
		super.init()
		
		planeGeometry = SCNPlane(width: CGFloat(anchor.extent.x),
		                         height: CGFloat(anchor.extent.z))
		
		let material = SCNMaterial()
		material.diffuse.contents = image
		self.planeGeometry.materials = [material]
		
		let planeNode = SCNNode(geometry: self.planeGeometry)
		planeNode.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
		
		// Planes in SceneKit are vertical by default so we need to rotate 90degrees to match
		// planes in ARKit
		planeNode.transform = SCNMatrix4MakeRotation(Float(-Double.pi / 2.0), 1.0, 0.0, 0.0);

		self.setTextureScale()
		self.addChildNode(planeNode)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func update(anchor:ARPlaneAnchor) {
		self.planeGeometry.width = CGFloat(anchor.extent.x)
		self.planeGeometry.height = CGFloat(anchor.extent.z)
		
		self.position = SCNVector3Make(anchor.center.x, 0, anchor.center.z)
		setTextureScale()
	}
	
	func setTextureScale() {
		let width = Float(self.planeGeometry.width)
		let height = Float(self.planeGeometry.height)
		
		guard let material = self.planeGeometry.materials.first else { return }
		material.diffuse.contentsTransform = SCNMatrix4MakeScale(width, height, 1)
		material.diffuse.wrapS = SCNWrapMode.repeat
		material.diffuse.wrapT = SCNWrapMode.repeat
	}
}
