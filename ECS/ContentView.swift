//
//  ContentView.swift
//  ECS
//
//  Created by IVAN CAMPOS on 7/26/25.
//

import SwiftUI
import RealityKit

struct ContentView: View {

    var body: some View {
        VStack {
            Text("ECS Demo")
                .font(.headline)
                .fontWeight(.heavy)
                .padding(.vertical)
            ToggleImmersiveSpaceButton()
        }
    }
}

//#Preview(windowStyle: .automatic) {
//    ContentView()
//        .environment(AppModel())
//}
