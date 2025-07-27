import RealityKit
import simd

class VibrateSystem: System {
    private static let query = EntityQuery(where: .has(VibrateComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var vib = entity.components[VibrateComponent.self] {
                vib.phase += vib.speed * dt
                let angle = sin(vib.phase) * vib.amplitude
                let q = simd_quatf(angle: angle, axis: [0, 1, 0])
                entity.orientation = simd_normalize(q * entity.orientation)
                entity.components.set(vib)
            }
        }
    }
}
