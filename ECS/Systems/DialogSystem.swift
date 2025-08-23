import RealityKit

class DialogSystem: System {
    private static let query = EntityQuery(where: .has(DialogComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var dialog = entity.components[DialogComponent.self] {
                            dialog.index += 1
                            entity.components.set(dialog)
                        }
        }
    }
}
