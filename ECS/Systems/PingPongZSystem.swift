import RealityKit
import simd

class PingPongZSystem: System {
    private static let query = EntityQuery(where: .has(PingPongZComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[PingPongZComponent.self] {
                comp.phase += comp.speed * dt
                entity.position.z = comp.origin + sin(comp.phase) * comp.amplitude
                entity.components.set(comp)
            }
        }
    }
}
