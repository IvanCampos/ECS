import RealityKit

class LifetimeSystem: System {
    private static let query = EntityQuery(where: .has(LifetimeComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var life = entity.components[LifetimeComponent.self] {
                life.timeRemaining -= context.deltaTime
                if life.timeRemaining <= 0 {
                    entity.removeFromParent()
                } else {
                    entity.components.set(life)
                }
            }
        }
    }
}
