import RealityKit

class PathFollowSystem: System {
    private static let query = EntityQuery(where: .has(PathFollowComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var path = entity.components[PathFollowComponent.self] {
                            path.index += 1
                            entity.components.set(path)
                        }
        }
    }
}
