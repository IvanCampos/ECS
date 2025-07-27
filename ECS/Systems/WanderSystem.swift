import RealityKit
import simd

class WanderSystem: System {
    private static let query = EntityQuery(where: .has(WanderComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let wander = entity.components[WanderComponent.self] {
                let randomOffset = SIMD3<Float>(
                    Float.random(in: -wander.range...wander.range) * dt,
                    Float.random(in: -wander.range...wander.range) * dt,
                    Float.random(in: -wander.range...wander.range) * dt
                )
                entity.position += randomOffset
            }
        }
    }
}
