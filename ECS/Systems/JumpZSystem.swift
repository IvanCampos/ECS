import RealityKit
import simd

class JumpZSystem: System {
    private static let query = EntityQuery(where: .has(JumpZComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[JumpZComponent.self] {
                comp.phase += comp.speed * dt
                entity.position.z = comp.origin + abs(sin(comp.phase)) * comp.height
                entity.components.set(comp)
            }
        }
    }
}
