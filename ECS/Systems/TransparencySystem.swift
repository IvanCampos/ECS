import RealityKit
import SwiftUI

class TransparencySystem: System {
    private static let query = EntityQuery(where: .has(TransparencyComponent.self) && .has(ModelComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[TransparencyComponent.self], var model = entity.components[ModelComponent.self] {
                comp.alpha = max(0, comp.alpha - comp.rate * dt)
                if let material = model.materials.first as? SimpleMaterial {
                    var m = material
                    m.color = .init(tint: material.color.tint.withAlphaComponent(CGFloat(comp.alpha)), texture: material.color.texture)
                    model.materials = [m]
                }
                entity.components.set(model)
                entity.components.set(comp)
            }
        }
    }
}
