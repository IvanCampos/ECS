import RealityKit
import SwiftUI

class GrowFadeSystem: System {
    private static let query = EntityQuery(where: .has(GrowFadeComponent.self) && .has(ModelComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[GrowFadeComponent.self], var model = entity.components[ModelComponent.self] {
                let factor = 1 + comp.growRate * dt
                entity.scale *= SIMD3<Float>(repeating: factor)
                comp.alpha = max(0, comp.alpha - comp.fadeRate * dt)
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
