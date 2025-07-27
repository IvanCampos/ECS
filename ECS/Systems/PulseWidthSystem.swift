import RealityKit
import simd

class PulseWidthSystem: System {
    private static let query = EntityQuery(where: .has(PulseWidthComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[PulseWidthComponent.self] {
                comp.phase += comp.speed * dt
                entity.scale.x = 1 + sin(comp.phase) * comp.amplitude
                entity.components.set(comp)
            }
        }
    }
}
