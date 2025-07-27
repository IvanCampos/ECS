import RealityKit

class BlinkSystem: System {
    private static let query = EntityQuery(where: .has(BlinkComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
            if var blink = entity.components[BlinkComponent.self] {
                blink.timer += context.deltaTime
                if blink.timer >= blink.interval {
                    blink.timer = 0
                    blink.visible.toggle()
                    entity.isEnabled = blink.visible
                }
                entity.components.set(blink)
            }
        }
    }
}
