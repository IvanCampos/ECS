import RealityKit

class JumpSystem: System {
    private static let query = EntityQuery(where: .has(JumpComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        let dt = Float(context.deltaTime)
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var comp = entity.components[JumpComponent.self] {
                comp.phase += comp.speed * dt
                entity.position.y = comp.origin + abs(sin(comp.phase)) * comp.height
                entity.components.set(comp)
            }
        }
    }
}
