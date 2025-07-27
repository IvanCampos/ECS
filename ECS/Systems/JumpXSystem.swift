import RealityKit
import simd

class JumpXSystem: System {
    private static let query = EntityQuery(where: .has(JumpXComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[JumpXComponent.self] {
                comp.phase += comp.speed * dt
                entity.position.x = comp.origin + abs(sin(comp.phase)) * comp.height
                entity.components.set(comp)
            }
        }
    }
}
