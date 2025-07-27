import RealityKit
import simd

class MoveYSystem: System {
    private static let query = EntityQuery(where: .has(MoveYComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let move = entity.components[MoveYComponent.self] {
                entity.position.y += move.speed * dt
            }
        }
    }
}
