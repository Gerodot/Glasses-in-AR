//
//  ContentView.swift
//  Glasses in AR
//
//  Created by Gerodot on 22.03.2022.
//

import ARKit
import SwiftUI
import RealityKit

struct ContentView : View {
    var body: some View {
        return ARViewContainer().edgesIgnoringSafeArea(.all)
    }
}

struct ARViewContainer: UIViewRepresentable {
    
    // Create Bridge Mash func
    func createBridge(x:Float = 0, y:Float = 0, z:Float = 0) -> Entity {
        // Create mash (geometry)
        let bridgeMesh = MeshResource.generateBox(size: 0.005, cornerRadius: 0.001)
        
        // Create box material
        let bridgeMaterial = SimpleMaterial(color: .systemGray, isMetallic: true)
        
        // Add mash to enitty
        let bridgeEntity = ModelEntity(mesh: bridgeMesh, materials: [bridgeMaterial])
        
        // Box entity position
        bridgeEntity.position = SIMD3(x, y, z)
 
        // Box scale
        bridgeEntity.scale.x = 6
        bridgeEntity.scale.z = 0.6
        
        return bridgeEntity
    }
    
    // Create glass mesh
    func createGlass(x:Float = 0, y:Float = 0, z:Float = 0) -> Entity {
        // Create circle geometry
        let glassMesh = MeshResource.generateBox(size: 0.035, cornerRadius: 0.015)
        
        // Add material
        let material = SimpleMaterial(color: .green, isMetallic: true)
        
        // Add circle to entity
        let glassEntity = ModelEntity(mesh: glassMesh, materials: [material])
        
        // Set position
        glassEntity.position = SIMD3(x, y, z)
        
        // Scale
        glassEntity.scale.x = 1.45
        glassEntity.scale.z = 0.01
        
        
        return glassEntity
    }
    
    func makeUIView(context: Context) -> ARView {
        // Create ARView
        let arView = ARView(frame: .zero)
        
        // Check face tracking conf is supported
        guard ARFaceTrackingConfiguration.isSupported else {
            print(#line,#function, "Sorry your device is ont supported face tracking")
            return arView
        }
        
        // Create face tracking config
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        // configuration.frameSemantics.insert(.personSegmentationWithDepth)
        
        // Run face tracking conf
        arView.session.run(configuration, options: [])
        
        // Create face ankhor
        let faceAnchor = AnchorEntity(.face)
        
        // Add mesh to face anchr
        faceAnchor.addChild(createGlass(x:0.036, y:0.02, z: 0.05))
        faceAnchor.addChild(createGlass(x:-0.036, y:0.02, z: 0.05))
        faceAnchor.addChild(createBridge(y:0.025, z: 0.05))
        
        // Add anchor to scene
        arView.scene.anchors.append(faceAnchor)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {}
    
}

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
