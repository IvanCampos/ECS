import RealityKit
import SwiftUI

class PulseOpacitySystem: System {
    private static let query = EntityQuery(where: .has(PulseOpacityComponent.self) && .has(ModelComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[PulseOpacityComponent.self], var model = entity.components[ModelComponent.self] {
                comp.phase += comp.speed * dt
                let alpha = max(0, min(1, comp.baseAlpha + sin(comp.phase) * comp.amplitude))
                if let material = model.materials.first as? SimpleMaterial {
                    var m = material
                    m.color = .init(tint: material.color.tint.withAlphaComponent(CGFloat(alpha)), texture: material.color.texture)
                    model.materials = [m]
                }
                entity.components.set(model)
                entity.components.set(comp)
            }
        }
    }
}
