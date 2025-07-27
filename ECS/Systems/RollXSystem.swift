import RealityKit
import simd

class RollXSystem: System {
    private static let query = EntityQuery(where: .has(RollXComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let roll = entity.components[RollXComponent.self] {
                let q = simd_quatf(angle: roll.speed * dt, axis: [1, 0, 0])
                entity.orientation = simd_normalize(q * entity.orientation)
            }
        }
    }
}
