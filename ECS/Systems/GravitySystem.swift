import RealityKit
import simd

class GravitySystem: System {
    private static let query = EntityQuery(where: .has(GravityComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var gravity = entity.components[GravityComponent.self] {
                gravity.velocity += gravity.acceleration * dt
                entity.position += gravity.velocity * dt
                entity.components.set(gravity)
            }
        }
    }
}
