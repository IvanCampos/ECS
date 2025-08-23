import RealityKit

class QuestSystem: System {
    private static let query = EntityQuery(where: .has(QuestComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var quest = entity.components[QuestComponent.self] {
                            if quest.completed { entity.isEnabled = false }
                        }
        }
    }
}
