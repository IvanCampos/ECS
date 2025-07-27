import RealityKit
import SwiftUI

class ShimmerSystem: System {
    private static let query = EntityQuery(where: .has(ShimmerComponent.self) && .has(ModelComponent.self))

    required init(scene: RealityKit.Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var shim = entity.components[ShimmerComponent.self], var model = entity.components[ModelComponent.self] {
                shim.phase += shim.speed * dt
                let brightness = (sin(shim.phase) + 1) / 2
                let color = UIColor(white: CGFloat(brightness), alpha: 1)
                model.materials = [SimpleMaterial(color: color, isMetallic: false)]
                entity.components.set(model)
                entity.components.set(shim)
            }
        }
    }
}
