import RealityKit
import simd

class PulseRotationSystem: System {
    private static let query = EntityQuery(where: .has(PulseRotationComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[PulseRotationComponent.self] {
                comp.phase += comp.speed * dt
                let angle = sin(comp.phase) * comp.amplitude
                let q = simd_quatf(angle: angle, axis: normalize(comp.axis))
                entity.orientation = simd_normalize(q)
                entity.components.set(comp)
            }
        }
    }
}
