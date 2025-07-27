import RealityKit
import simd

class BeelineSystem: System {
    private static let query = EntityQuery(where: .has(BeelineComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let comp = entity.components[BeelineComponent.self] {
                entity.position += comp.direction * comp.speed * dt
            }
        }
    }
}
