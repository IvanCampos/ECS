import RealityKit
import SwiftUI

class DriftColorSystem: System {
    private static let query = EntityQuery(where: .has(DriftColorComponent.self) && .has(ModelComponent.self))

    required init(scene: RealityKit.Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[DriftColorComponent.self], var model = entity.components[ModelComponent.self] {
                entity.position += comp.velocity * dt
                comp.phase += comp.speed * dt
                let t = (sin(comp.phase) + 1) / 2
                let color = UIColor(red: CGFloat(t), green: CGFloat(1 - t), blue: 1, alpha: 1)
                model.materials = [SimpleMaterial(color: color, isMetallic: false)]
                entity.components.set(model)
                entity.components.set(comp)
            }
        }
    }
}
