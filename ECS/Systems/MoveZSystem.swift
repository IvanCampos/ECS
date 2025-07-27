import RealityKit
import simd

class MoveZSystem: System {
    private static let query = EntityQuery(where: .has(MoveZComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let move = entity.components[MoveZComponent.self] {
                entity.position.z += move.speed * dt
            }
        }
    }
}
