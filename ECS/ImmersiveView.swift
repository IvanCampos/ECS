//
//  ImmersiveView.swift
//  ECS
//
//  Created by IVAN CAMPOS on 7/26/25.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct ImmersiveView: View {
    @Environment(AppModel.self) var appModel

    var body: some View {
        RealityView { content in
            // Add the initial RealityKit content
            if let immersiveContentEntity = try? await Entity(named: "SkyDome", in: realityKitContentBundle) {
                content.add(immersiveContentEntity)
            }
            
            // Anchor one meter in front of the user’s head pose.
            let anchor = AnchorEntity(.head)
            anchor.position = [0, 0, -1.0]
            
            // Create a cube mesh with a basic material.
            let cube = ModelEntity(
                mesh: .generateBox(size: 0.25),
                materials: [SimpleMaterial(color: .cyan, isMetallic: false)]
            )
            
            // Attach the RotateComponent so RotateSystem will update it.
            cube.components.set(RotateComponent(axis: [0, 1, 0], speed: .pi)) // π rad ≈ 180 °/s
            
            anchor.addChild(cube)
            content.add(anchor)
            
        }
    }
}

//#Preview(immersionStyle: .full) {
//    ImmersiveView()
//        .environment(AppModel())
//}
