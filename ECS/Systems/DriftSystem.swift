import RealityKit
import simd

class DriftSystem: System {
    private static let query = EntityQuery(where: .has(DriftComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let drift = entity.components[DriftComponent.self] {
                entity.position += drift.velocity * dt
            }
        }
    }
}
