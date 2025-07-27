import RealityKit
import simd

class MagnetSystem: System {
    private static let query = EntityQuery(where: .has(MagnetComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var magnet = entity.components[MagnetComponent.self] {
                let dir = magnet.target - entity.position
                magnet.velocity += dir * magnet.strength * dt
                entity.position += magnet.velocity * dt
                entity.components.set(magnet)
            }
        }
    }
}
