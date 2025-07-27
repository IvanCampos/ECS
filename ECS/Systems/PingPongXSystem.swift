import RealityKit
import simd

class PingPongXSystem: System {
    private static let query = EntityQuery(where: .has(PingPongXComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[PingPongXComponent.self] {
                comp.phase += comp.speed * dt
                entity.position.x = comp.origin + sin(comp.phase) * comp.amplitude
                entity.components.set(comp)
            }
        }
    }
}
