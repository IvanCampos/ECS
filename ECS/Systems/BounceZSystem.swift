import RealityKit
import simd

class BounceZSystem: System {
    private static let query = EntityQuery(where: .has(BounceZComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var bounce = entity.components[BounceZComponent.self] {
                bounce.phase += bounce.speed * dt
                entity.position.z = bounce.origin.z + sin(bounce.phase) * bounce.amplitude
                entity.components.set(bounce)
            }
        }
    }
}
