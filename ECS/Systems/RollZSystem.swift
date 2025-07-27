import RealityKit
import simd

class RollZSystem: System {
    private static let query = EntityQuery(where: .has(RollZComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let roll = entity.components[RollZComponent.self] {
                let q = simd_quatf(angle: roll.speed * dt, axis: [0, 0, 1])
                entity.orientation = simd_normalize(q * entity.orientation)
            }
        }
    }
}
