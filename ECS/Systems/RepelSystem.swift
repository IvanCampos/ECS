import RealityKit
import simd

class RepelSystem: System {
    private static let query = EntityQuery(where: .has(RepelComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var repel = entity.components[RepelComponent.self] {
                let dir = entity.position - repel.target
                repel.velocity += dir * repel.strength * dt
                entity.position += repel.velocity * dt
                entity.components.set(repel)
            }
        }
    }
}
