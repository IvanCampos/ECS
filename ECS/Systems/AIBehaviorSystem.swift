import RealityKit

class AIBehaviorSystem: System {
    private static let query = EntityQuery(where: .has(AIBehaviorComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var ai = entity.components[AIBehaviorComponent.self] {
                            ai.state += 1
                            entity.components.set(ai)
                        }
        }
    }
}
