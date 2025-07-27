import RealityKit
import simd

class BounceXSystem: System {
    private static let query = EntityQuery(where: .has(BounceXComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var bounce = entity.components[BounceXComponent.self] {
                bounce.phase += bounce.speed * dt
                entity.position.x = bounce.origin.x + sin(bounce.phase) * bounce.amplitude
                entity.components.set(bounce)
            }
        }
    }
}
