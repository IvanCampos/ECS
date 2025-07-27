import RealityKit
import simd

class SeekSystem: System {
    private static let query = EntityQuery(where: .has(SeekComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let seek = entity.components[SeekComponent.self] {
                let dir = normalize(seek.target - entity.position)
                entity.position += dir * seek.speed * dt
            }
        }
    }
}
