//
//  ECSApp.swift
//  ECS
//
//  Created by IVAN CAMPOS on 7/26/25.
//

import SwiftUI
import RealityKit

@main
struct ECSApp: App {
    
    @State private var appModel = AppModel()
    
    init() {
        MyComponent.registerComponent()
        MySystem.registerSystem()
    }
    
    var body: some SwiftUI.Scene {
        WindowGroup {
            ContentView()
                .environment(appModel)
        }
        
        ImmersiveSpace(id: appModel.immersiveSpaceID) {
            ImmersiveView()
                .environment(appModel)
                .onAppear {
                    appModel.immersiveSpaceState = .open
                }
                .onDisappear {
                    appModel.immersiveSpaceState = .closed
                }
        }
        .immersionStyle(selection: .constant(.full), in: .full)
    }
}
