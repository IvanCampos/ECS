import RealityKit
import simd

class PulseDepthSystem: System {
    private static let query = EntityQuery(where: .has(PulseDepthComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[PulseDepthComponent.self] {
                comp.phase += comp.speed * dt
                entity.scale.z = 1 + sin(comp.phase) * comp.amplitude
                entity.components.set(comp)
            }
        }
    }
}
