import RealityKit
import simd
import SwiftUI

class BlinkColorSystem: System {
    private static let query = EntityQuery(where: .has(BlinkColorComponent.self) && .has(ModelComponent.self))

    required init(scene: RealityKit.Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[BlinkColorComponent.self], var model = entity.components[ModelComponent.self] {
                comp.timer += dt
                if comp.timer >= comp.interval {
                    comp.timer = 0
                    comp.useA.toggle()
                }
                let vec = comp.useA ? comp.colorA : comp.colorB
                let color = UIColor(red: CGFloat(vec.x), green: CGFloat(vec.y), blue: CGFloat(vec.z), alpha: 1)
                model.materials = [SimpleMaterial(color: color, isMetallic: false)]
                entity.components.set(model)
                entity.components.set(comp)
            }
        }
    }
}
