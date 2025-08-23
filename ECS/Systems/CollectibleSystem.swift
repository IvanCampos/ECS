import RealityKit

class CollectibleSystem: System {
    private static let query = EntityQuery(where: .has(CollectibleComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var item = entity.components[CollectibleComponent.self] {
                            if item.collected { entity.isEnabled = false }
                        }
        }
    }
}
