import RealityKit

class AlignSystem: System {
    private static let query = EntityQuery(where: .has(AlignComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            entity.orientation = .init()
        }
    }
}
