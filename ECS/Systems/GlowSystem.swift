import RealityKit
import SwiftUI

class GlowSystem: System {
    private static let query = EntityQuery(where: .has(GlowComponent.self) && .has(ModelComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let glow = entity.components[GlowComponent.self], var model = entity.components[ModelComponent.self] {
                let color = UIColor(white: 1, alpha: CGFloat(glow.intensity))
                let material = SimpleMaterial(color: color, isMetallic: false)
                model.materials = [material]
                entity.components.set(model)
            }
        }
    }
}
