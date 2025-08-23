import RealityKit

class PickupSystem: System {
    private static let query = EntityQuery(where: .has(PickupComponent.self))

    required init(scene: Scene) { }

    func update(context: SceneUpdateContext) {
        for entity in context.entities(matching: Self.query, updatingSystemWhen: .rendering) {
                        if var pickup = entity.components[PickupComponent.self] {
                            if pickup.picked { entity.isEnabled = false }
                        }
        }
    }
}
