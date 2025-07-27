//
//  SpinSystem.swift
//  ECS
//
//  Created by IVAN CAMPOS on 7/26/25.
//


import RealityKit

class MySystem: System {


    // Define a query to return all entities with a MyComponent.
    private static let query = EntityQuery(where: .has(MyComponent.self))


    // Initializer is required. Use an empty implementation if there's no setup needed.
    required init(scene: Scene) { }


    // Iterate through all entities containing a MyComponent.
    func update(context: SceneUpdateContext) {
        for entity in context.entities(
            matching: Self.query,
            updatingSystemWhen: .rendering
        ) {
            // Make per-update changes to each entity here.
        }
    }
}
