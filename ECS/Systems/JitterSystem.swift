import RealityKit
import simd

class JitterSystem: System {
    private static let query = EntityQuery(where: .has(JitterComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let jitter = entity.components[JitterComponent.self] {
                let range = jitter.amplitude * dt
                let offset = SIMD3<Float>(
                    Float.random(in: -range...range),
                    Float.random(in: -range...range),
                    Float.random(in: -range...range)
                )
                entity.position += offset
            }
        }
    }
}
