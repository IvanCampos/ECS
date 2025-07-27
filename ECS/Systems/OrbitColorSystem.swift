import RealityKit
import SwiftUI
import simd

class OrbitColorSystem: System {
    private static let query = EntityQuery(where: .has(OrbitColorComponent.self) && .has(ModelComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[OrbitColorComponent.self], var model = entity.components[ModelComponent.self] {
                comp.angle += comp.speed * dt
                comp.phase += comp.colorSpeed * dt
                entity.position.x = comp.center.x + cos(comp.angle) * comp.radius
                entity.position.z = comp.center.z + sin(comp.angle) * comp.radius
                let t = (sin(comp.phase) + 1) / 2
                let color = UIColor(red: CGFloat(1 - t), green: CGFloat(t), blue: CGFloat(t), alpha: 1)
                model.materials = [SimpleMaterial(color: color, isMetallic: false)]
                entity.components.set(model)
                entity.components.set(comp)
            }
        }
    }
}
