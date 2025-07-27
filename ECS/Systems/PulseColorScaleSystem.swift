import RealityKit
import SwiftUI

class PulseColorScaleSystem: System {
    private static let query = EntityQuery(where: .has(PulseColorScaleComponent.self) && .has(ModelComponent.self))

    required init(scene: RealityKit.Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[PulseColorScaleComponent.self], var model = entity.components[ModelComponent.self] {
                comp.phase += comp.speed * dt
                let t = (sin(comp.phase) + 1) / 2
                let colorVec = comp.colorA * (1 - t) + comp.colorB * t
                let color = UIColor(red: CGFloat(colorVec.x), green: CGFloat(colorVec.y), blue: CGFloat(colorVec.z), alpha: 1)
                let scale = 1 + comp.amplitude * sin(comp.phase)
                entity.scale = [scale, scale, scale]
                model.materials = [SimpleMaterial(color: color, isMetallic: false)]
                entity.components.set(model)
                entity.components.set(comp)
            }
        }
    }
}
