import RealityKit
import simd

class BounceSystem: System {
    private static let query = EntityQuery(where: .has(BounceComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var bounce = entity.components[BounceComponent.self] {
                bounce.phase += bounce.speed * dt
                entity.position = bounce.origin + [0, sin(bounce.phase) * bounce.amplitude, 0]
                entity.components.set(bounce)
            }
        }
    }
}
