import RealityKit
import simd

class StretchSystem: System {
    private static let query = EntityQuery(where: .has(StretchComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var stretch = entity.components[StretchComponent.self] {
                stretch.phase += stretch.speed * dt
                let scale = 1 + sin(stretch.phase) * stretch.amplitude
                let factor = SIMD3<Float>(repeating: 1) + stretch.axis * (scale - 1)
                entity.scale = factor
                entity.components.set(stretch)
            }
        }
    }
}
