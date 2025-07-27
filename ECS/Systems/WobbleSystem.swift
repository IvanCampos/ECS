import RealityKit
import simd

class WobbleSystem: System {
    private static let query = EntityQuery(where: .has(WobbleComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var wobble = entity.components[WobbleComponent.self] {
                wobble.phase += wobble.speed * dt
                let angle = sin(wobble.phase) * wobble.amplitude
                let q = simd_quatf(angle: angle, axis: wobble.axis)
                entity.orientation = simd_normalize(q)
                entity.components.set(wobble)
            }
        }
    }
}
