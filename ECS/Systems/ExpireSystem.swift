import RealityKit

class ExpireSystem: System {
    private static let query = EntityQuery(where: .has(ExpireComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var expire = entity.components[ExpireComponent.self] {
                expire.timeRemaining -= context.deltaTime
                if expire.timeRemaining <= 0 {
                    entity.removeFromParent()
                } else {
                    entity.components.set(expire)
                }
            }
        }
    }
}
