import RealityKit
import simd

class ShakeSystem: System {
    private static let query = EntityQuery(where: .has(ShakeComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var shake = entity.components[ShakeComponent.self] {
                shake.phase += shake.speed * dt
                let offset = SIMD3<Float>(
                    sin(shake.phase) * shake.amplitude,
                    sin(shake.phase * 1.3) * shake.amplitude,
                    sin(shake.phase * 0.7) * shake.amplitude
                )
                entity.position += offset * dt
                entity.components.set(shake)
            }
        }
    }
}
