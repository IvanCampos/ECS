import RealityKit

class InputSystem: System {
    private static let query = EntityQuery(where: .has(InputComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var input = entity.components[InputComponent.self] {
                            input.isActive = false
                            entity.components.set(input)
                        }
        }
    }
}
