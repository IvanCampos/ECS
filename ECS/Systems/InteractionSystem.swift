import RealityKit

class InteractionSystem: System {
    private static let query = EntityQuery(where: .has(InteractionComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var interact = entity.components[InteractionComponent.self] {
                            interact.triggered = false
                            entity.components.set(interact)
                        }
        }
    }
}
