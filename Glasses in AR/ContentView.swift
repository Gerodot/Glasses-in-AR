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
    
    func makeUIView(context: Context) -> ARView {
        // Create ARView
        let arView = ARView(frame: .zero)
        
        // Check face tracking conf is supported
        guard ARFaceTrackingConfiguration.isSupported else {
            print(#line,#function, "Sorry your device is ont supported face tracking")
            return arView
        }
        
        //Create face tracking config
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        
        //Run face tracking conf
        arView.session.run(configuration, options: [])
        
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
