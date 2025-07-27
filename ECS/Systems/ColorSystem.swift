import RealityKit
import SwiftUI

class ColorSystem: System {
    private static let query = EntityQuery(where: .has(ColorComponent.self) && .has(ModelComponent.self))

    required init(scene: RealityKit.Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let colorComp = entity.components[ColorComponent.self], var model = entity.components[ModelComponent.self] {
                let material = SimpleMaterial(color: UIColor(colorComp.color), isMetallic: false)
                model.materials = [material]
                entity.components.set(model)
            }
        }
    }
}
