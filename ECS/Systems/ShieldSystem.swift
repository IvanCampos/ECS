import RealityKit

class ShieldSystem: System {
    private static let query = EntityQuery(where: .has(ShieldComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var shield = entity.components[ShieldComponent.self] {
                            if shield.strength > shield.max { shield.strength = shield.max }
                            if shield.strength < 0 { shield.strength = 0 }
                            entity.components.set(shield)
                        }
        }
    }
}
