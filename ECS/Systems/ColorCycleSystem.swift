import RealityKit
import simd
import SwiftUI

class ColorCycleSystem: System {
    private static let query = EntityQuery(where: .has(ColorCycleComponent.self) && .has(ModelComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var cycle = entity.components[ColorCycleComponent.self], var model = entity.components[ModelComponent.self] {
                cycle.hue += cycle.speed * dt
                if cycle.hue > 1 { cycle.hue -= 1 }
                let color = UIColor(hue: CGFloat(cycle.hue), saturation: 1, brightness: 1, alpha: 1)
                model.materials = [SimpleMaterial(color: color, isMetallic: false)]
                entity.components.set(model)
                entity.components.set(cycle)
            }
        }
    }
}
