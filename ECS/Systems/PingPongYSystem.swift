import RealityKit
import simd

class PingPongYSystem: System {
    private static let query = EntityQuery(where: .has(PingPongYComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[PingPongYComponent.self] {
                comp.phase += comp.speed * dt
                entity.position.y = comp.origin + sin(comp.phase) * comp.amplitude
                entity.components.set(comp)
            }
        }
    }
}
