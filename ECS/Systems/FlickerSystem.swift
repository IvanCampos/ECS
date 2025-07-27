import RealityKit

class FlickerSystem: System {
    private static let query = EntityQuery(where: .has(FlickerComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if let flicker = entity.components[FlickerComponent.self] {
                if Float.random(in: 0...1) < flicker.probability {
                    entity.isEnabled.toggle()
                }
            }
        }
    }
}
