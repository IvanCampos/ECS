import RealityKit
import SwiftUI
import simd

class ColorRiseSystem: System {
    private static let query = EntityQuery(where: .has(ColorRiseComponent.self) && .has(ModelComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[ColorRiseComponent.self], var model = entity.components[ModelComponent.self] {
                entity.position.y += comp.speed * dt
                let t = min(1, entity.position.y / comp.height)
                let colorVec = comp.colorA * (1 - t) + comp.colorB * t
                let color = UIColor(red: CGFloat(colorVec.x), green: CGFloat(colorVec.y), blue: CGFloat(colorVec.z), alpha: 1)
                model.materials = [SimpleMaterial(color: color, isMetallic: false)]
                entity.components.set(model)
                entity.components.set(comp)
            }
        }
    }
}
