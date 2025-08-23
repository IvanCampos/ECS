import RealityKit

class InventorySystem: System {
    private static let query = EntityQuery(where: .has(InventoryComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var inv = entity.components[InventoryComponent.self] {
                            entity.components.set(inv)
                        }
        }
    }
}
