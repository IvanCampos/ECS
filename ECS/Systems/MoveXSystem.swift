import RealityKit
import simd

class MoveXSystem: System {
    private static let query = EntityQuery(where: .has(MoveXComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let move = entity.components[MoveXComponent.self] {
                entity.position.x += move.speed * dt
            }
        }
    }
}
