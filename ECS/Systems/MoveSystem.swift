import RealityKit
import simd

class MoveSystem: System {
    private static let query = EntityQuery(where: .has(MoveComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let move = entity.components[MoveComponent.self] {
                entity.position += move.velocity * dt
            }
        }
    }
}
