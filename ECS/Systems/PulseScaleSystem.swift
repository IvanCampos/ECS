import RealityKit
import simd

class PulseScaleSystem: System {
    private static let query = EntityQuery(where: .has(PulseScaleComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var pulse = entity.components[PulseScaleComponent.self] {
                pulse.phase += pulse.speed * dt
                let scale = 1 + sin(pulse.phase) * pulse.amplitude
                entity.scale = SIMD3<Float>(repeating: scale)
                entity.components.set(pulse)
            }
        }
    }
}
